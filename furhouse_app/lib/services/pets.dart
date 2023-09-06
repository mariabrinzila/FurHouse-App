import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:collection';
import 'dart:io';

import 'package:furhouse_app/models/petVM.dart';

class Pets {
  Future<String> add(PetVM pet) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("pets");

      var snapshot = await databaseRef.limitToLast(1).get();

      if (!snapshot.exists) {
        throw 'Adding a pet is currently unavailable!';
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
        throw 'No available data!';
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
        throw 'No available data!';
      }

      var length = snapshot.value.toString();
      print(length);

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
      );

      var photoURL =
          await getPetPhoneDownloadURL(currentPet.userEmail, currentPet.name);

      petDataMap.addEntries(<String, PetVM>{photoURL: currentPet}.entries);
    }

    return petDataMap;
  }
}
