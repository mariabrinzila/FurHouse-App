import 'package:sqflite/sqflite.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:collection';
import 'dart:io';

import 'package:furhouse_app/models/petVM.dart';

class Pets {
  late Database _database;

  static const _databaseName = "furhouse-app-database.db";
  static const _databaseVersion = 1;
  static const _table = "pets";

  Future<void> init() async {
    //final documentsDirectory = await getApplicationDocumentsDirectory();
    //final path = join(documentsDirectory.path, _databaseName);

    //final databasesPath = await getDatabasesPath();
    //final path = join(databasesPath, _databaseName);

    /*var path = _databaseName;

    if (kIsWeb) {
      // Change default factory on the web
      databaseFactory = databaseFactoryFfiWeb;
      path = "F:/sqlite/furhouse-app-database.db";

      // open the database
      _database = await openDatabase(path);

      // create table, if it doesn't already exist
      await _onCreate(_database, _databaseVersion);
    } else {
      _database = await openDatabase(
        _databaseName,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    }*/

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
            adopted INTEGER NOT NULL
          )
      ''',
    );
  }

  Future<Map<String, PetVM>> selectPaginatedPets(int index, int limit) async {
    try {
      await init();

      // select pets with an id >= the page and limit results by the given limit
      final List<Map<String, dynamic>> pets = await _database.query(
        _table,
        where: "pet_id >= ?",
        whereArgs: [index],
        limit: limit,
      );

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      await closeDatabase();

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
      );

      var photoURL =
          await getPetPhoneDownloadURL(currentPet.userEmail, currentPet.name);

      petDataMap.addEntries(<String, PetVM>{photoURL: currentPet}.entries);
    }

    return petDataMap;
  }

  Future<Map<String, PetVM>> selectSortedPets(
      String sortOption, bool sortOrderAscending) async {
    try {
      await init();

      final List<Map<String, dynamic>> pets;
      var sortOrder = "ASC";

      if (!sortOrderAscending) {
        sortOrder = "DESC";
      }

      if (sortOption != "age") {
        var option = sortOption == "name" ? sortOption : "date_added";

        pets = await _database.query(
          _table,
          orderBy: "$option $sortOrder",
        );
      } else {
        pets = await _database.query(
          _table,
          orderBy: "age_unit $sortOrder, age_value $sortOrder",
        );
      }

      if (pets.isEmpty) {
        throw "No available data!";
      }

      var petDataMap = _computePetMapFromDatabaseData(pets);

      await closeDatabase();

      return petDataMap;
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getPetPhoneDownloadURL(
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

  Future<String> insert(PetVM pet) async {
    try {
      await init();

      var id = 1;

      // get the id of the pet added last
      final List<Map<String, dynamic>> lastAddedPet =
          await _database.query(_table, orderBy: "pet_id DESC", limit: 1);

      if (lastAddedPet.isNotEmpty) {
        id = lastAddedPet[0]["pet_id"] + 1;
      }

      // add pet in the database
      await _database.insert(
        _table,
        pet.toMap(id),
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

  closeDatabase() async {
    await _database.close();
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

      return 'Success';
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
      );

      var photoURL =
          await getPetPhoneDownloadURL(currentPet.userEmail, currentPet.name);

      petDataMap.addEntries(<String, PetVM>{photoURL: currentPet}.entries);
    }

    return petDataMap;
  }
}
