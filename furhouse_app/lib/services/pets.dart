import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:collection';
import 'dart:io';

import 'package:furhouse_app/models/pet_VM.dart';

class Pets {
  late Database _database;

  static const _databaseName = "furhouse-app-database.db";
  static const _databaseVersion = 1;
  static const _table = "pets";

  Future<void> init() async {
    _database = await openDatabase(
      _databaseName,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database database, int version) async {
    await database.execute(
      '''
          CREATE TABLE IF NOT EXISTS $_table (
            pet_id INTEGER PRIMARY KEY,
            name TEXT NOT NULL,
            gender TEXT NOT NULL,
            category TEXT NOT NULL,
            breed TEXT NOT NULL,
            age_unit TEXT NOT NULL,
            age_value INTEGER NOT NULL,
            location TEXT NOT NULL,
            details TEXT NOT NULL,
            priority TEXT NOT NULL,
            description TEXT,
            user_email TEXT NOT NULL,
            date_added TEXT NOT NULL,
            adopted INTEGER NOT NULL,
            adopted_by TEXT
          )
      ''',
    );
  }

  Future<String> insert(PetVM pet) async {
    try {
      await init();

      var petId = 1;

      // get the id of the pet added last
      final List<Map<String, dynamic>> lastAddedPet = await _database.query(
        _table,
        orderBy: "pet_id DESC",
        limit: 1,
      );

      if (lastAddedPet.isNotEmpty) {
        petId = lastAddedPet[0]["pet_id"] + 1;
      }

      pet.id = petId;

      // add pet in the database
      await _database.insert(
        _table,
        pet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.rollback,
      );

      // add pet photo in the storage
      var photo = File(pet.photoPath);

      await FirebaseStorage.instance
          .ref(pet.userEmail)
          .child(pet.name)
          .putFile(photo);

      await closeDatabase();

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<int?> readTotalNumberOfPets() async {
    try {
      await init();

      //await _database.rawQuery("ALTER TABLE $_table ADD adopted_by TEXT");
      //await _database.rawQuery("DELETE FROM $_table WHERE adopted = 1");
      //await _database.rawQuery("DELETE FROM $_table WHERE name = 'Alba'");

      var query = "SELECT COUNT(*) FROM $_table WHERE adopted = 0";

      final total = Sqflite.firstIntValue(
        await _database.rawQuery(query),
      );

      await closeDatabase();

      return total;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> readPaginatedPets(int index, int limit) async {
    try {
      await init();

      final List<Map<String, dynamic>> pets = await _database.query(
        _table,
        where: "adopted = 0",
        orderBy: "pet_id ASC",
        offset: index - 1,
        limit: limit,
      );

      await closeDatabase();

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> _computePetMapFromDatabaseData(
      List<Map<String, dynamic>> pets) async {
    // compute PetVM object from database data and get corresponding pet photos
    var petDataMap = <String, PetVM>{};

    for (var pet in pets) {
      var currentPet = PetVM(
        name: pet["name"],
        gender: pet["gender"],
        category: pet["category"],
        breed: pet["breed"],
        ageUnit: pet["age_unit"],
        ageValue: pet["age_value"],
        location: pet["location"],
        details: pet["details"],
        priority: pet["priority"],
        description: pet["description"],
        userEmail: pet["user_email"],
        photoPath: "",
        dateAdded: pet["date_added"],
        adopted: pet["adopted"] == 0 ? false : true,
        adoptedBy: pet["adopted_by"],
      );

      currentPet.id = pet["pet_id"];

      var photoURL =
          await getPetPhotoDownloadURL(currentPet.userEmail, currentPet.name);

      petDataMap.addEntries(<String, PetVM>{photoURL: currentPet}.entries);
    }

    return petDataMap;
  }

  Future<String> getPetPhotoDownloadURL(
      String userEmail, String petName) async {
    try {
      return await FirebaseStorage.instance
          .ref(userEmail)
          .child(petName)
          .getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> readSortFilterSearchPets(
      String sortOption,
      bool sortOrderAscending,
      String filterOption,
      String filterCriteria,
      String searchOption,
      String searchCriteria) async {
    try {
      await init();

      final List<Map<String, dynamic>> pets;
      String query = "SELECT * FROM $_table";
      List<String> queryParameters = [];
      var adoptedAdded = false;

      if (filterOption.isNotEmpty) {
        adoptedAdded = true;
        query = "$query WHERE adopted = 0 AND $filterOption = ?";

        queryParameters.add(filterCriteria);
      }

      if (searchOption.isNotEmpty) {
        adoptedAdded = true;

        if (queryParameters.isEmpty) {
          query =
              "$query WHERE adopted = 0 AND $searchOption LIKE '%$searchCriteria%'";
        } else {
          query = "$query AND $searchOption LIKE '%$searchCriteria%'";
        }
      }

      if (sortOption.isNotEmpty) {
        var sortOrder = "ASC";
        var orderBy = "";

        if (!sortOrderAscending) {
          sortOrder = "DESC";
        }

        if (!adoptedAdded) {
          query = "$query WHERE adopted = 0";
        }

        if (sortOption != "age") {
          var option = sortOption == "name" ? sortOption : "date_added";
          orderBy = "$option $sortOrder";
        } else {
          orderBy = "age_unit $sortOrder, age_value $sortOrder";
        }

        query = "$query ORDER BY $orderBy";
      }

      if (queryParameters.isEmpty) {
        pets = await _database.rawQuery(query);
      } else {
        pets = await _database.rawQuery(query, queryParameters);
      }

      await closeDatabase();

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> readAddedPets(String userEmail) async {
    try {
      await init();

      final List<Map<String, dynamic>> pets = await _database.query(
        _table,
        where: "adopted = 0 AND user_email = ?",
        whereArgs: [userEmail],
        orderBy: "date_added DESC",
      );

      await closeDatabase();

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> readAdoptedPets(String userEmail) async {
    try {
      await init();

      final List<Map<String, dynamic>> pets = await _database.query(
        _table,
        where: "adopted = 1 AND adopted_by = ?",
        whereArgs: [userEmail],
        orderBy: "date_added DESC",
      );

      await closeDatabase();

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> update(
      PetVM pet, String previousName, String? petPhotoURL) async {
    try {
      await init();

      // update pet in the database
      await _database.update(
        _table,
        pet.toMap(),
        where: "pet_id = ?",
        whereArgs: [pet.petId],
      );

      var petName = previousName;

      if (pet.name != previousName) {
        petName = pet.name;

        // create a reference to the photo
        final photoReference =
            FirebaseStorage.instance.refFromURL(petPhotoURL!);

        // get photo data from photo reference
        const oneMegabyte = 1024 * 1024;
        var photoData = await photoReference.getData(oneMegabyte);

        // create a new pet photo with the new name
        await FirebaseStorage.instance
            .ref(pet.userEmail)
            .child(pet.name)
            .putData(photoData!);
        //.putFile(photo);

        // delete pet photo with the previous name
        await FirebaseStorage.instance
            .ref(pet.userEmail)
            .child(previousName)
            .delete();
      }

      if (pet.photoPath != petPhotoURL) {
        // delete pet photo with the previous name
        await FirebaseStorage.instance
            .ref(pet.userEmail)
            .child(petName)
            .delete();

        // add new pet photo in the storage
        var photo = File(pet.photoPath);

        await FirebaseStorage.instance
            .ref(pet.userEmail)
            .child(petName)
            .putFile(photo);
      }

      await closeDatabase();

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> delete(int petId, String userEmail, String petName) async {
    try {
      await init();

      // delete pet from the database
      await _database.delete(
        _table,
        where: "pet_id = ?",
        whereArgs: [petId],
      );

      // delete pet photo from storage
      await FirebaseStorage.instance.ref(userEmail).child(petName).delete();

      await closeDatabase();

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateAdoptPet(int petId, String userEmail) async {
    try {
      await init();

      // update the adopt field for the current pet accordingly
      var query =
          "UPDATE $_table SET adopted = 1, adopted_by = '$userEmail' WHERE pet_id = $petId";

      await _database.rawQuery(query);

      await closeDatabase();

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<int?> readNumberOfAddedPets(String userEmail) async {
    try {
      await init();

      var query =
          "SELECT COUNT(*) FROM $_table WHERE user_email = '$userEmail'";

      final total = Sqflite.firstIntValue(
        await _database.rawQuery(query),
      );

      await closeDatabase();

      return total;
    } catch (e) {
      rethrow;
    }
  }

  Future<int?> readNumberOfAdoptedPets(String userEmail) async {
    try {
      await init();

      var query =
          "SELECT COUNT(*) FROM $_table WHERE adopted_by = '$userEmail'";

      final total = Sqflite.firstIntValue(
        await _database.rawQuery(query),
      );

      await closeDatabase();

      return total;
    } catch (e) {
      rethrow;
    }
  }

  closeDatabase() async {
    await _database.close();
  }

  // optional functions from here on

  Future<bool> petNameAlreadyExists(String name) async {
    try {
      await init();

      // select pets with the given name
      final List<Map<String, dynamic>> pets = await _database.query(
        _table,
        where: "name = ?",
        whereArgs: [name],
      );

      await closeDatabase();

      if (pets.isEmpty) {
        return false;
      }

      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addPet(PetVM pet) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("pets");

      var snapshot = await databaseRef.limitToLast(1).get();

      if (!snapshot.exists) {
        throw "Adding a pet is currently unavailable!";
      }

      var petData = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      int index = 1;

      for (var key in petData.keys) {
        var petObject = petData[key];
        index = petObject["index"];
      }

      index++;

      // add pet in the pets collection
      await databaseRef.push().set({
        "name": pet.name,
        "gender": pet.gender,
        "category": pet.category,
        "breed": pet.breed,
        "ageUnit": pet.ageUnit,
        "ageValue": pet.ageValue,
        "location": pet.location,
        "details": pet.details,
        "priority": pet.priority,
        "description": pet.description,
        "userEmail": pet.userEmail,
        "index": index,
      });

      // add pet photo in the storage
      var photo = File(pet.photoPath);

      await FirebaseStorage.instance
          .ref(pet.userEmail)
          .child(pet.name)
          .putFile(photo);

      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Future<Map<String, PetVM>> getAllPaginatedPets(int index, int limit) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("pets");

    try {
      var snapshot = await databaseRef
          .orderByChild("index")
          .startAt(index)
          .limitToFirst(limit)
          .get();

      if (!snapshot.exists) {
        throw "No available data!";
      }

      var petDataMap = await _mapDatabaseSnapshotToPetObject(snapshot);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> getAllSortedPets(
      String sortOption, bool sortOrderAscending, int index, int limit) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("pets");

    try {
      DataSnapshot snapshot;

      if (sortOrderAscending) {
        snapshot = await databaseRef.orderByChild("index").get();
      } else {
        snapshot = await databaseRef
            .orderByChild(sortOption)
            .startAt(index)
            .limitToLast(limit)
            .get();
      }

      if (!snapshot.exists) {
        throw "No available data!";
      }

      var petDataMap = await _mapDatabaseSnapshotToPetObject(snapshot);

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, PetVM>> _mapDatabaseSnapshotToPetObject(
      DataSnapshot snapshot) async {
    Map<String, PetVM> petDataMap = <String, PetVM>{};

    var petData = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);

    for (var key in petData.keys) {
      var petObject = petData[key];

      var currentPet = PetVM(
        name: petObject["name"],
        gender: petObject["gender"],
        category: petObject["category"],
        breed: petObject["breed"],
        ageUnit: petObject["ageUnit"],
        ageValue: petObject["ageValue"],
        location: petObject["location"],
        details: petObject["details"],
        priority: petObject["priority"],
        description: petObject["description"],
        userEmail: petObject["userEmail"],
        photoPath: '',
        dateAdded: petObject["date_added"],
        adopted: petObject["adopted"],
        adoptedBy: petObject["adopted_by"],
      );

      var photoURL =
          await getPetPhotoDownloadURL(currentPet.userEmail, currentPet.name);

      petDataMap.addEntries(<String, PetVM>{photoURL: currentPet}.entries);
    }

    return petDataMap;
  }
}
