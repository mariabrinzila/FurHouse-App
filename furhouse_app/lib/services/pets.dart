import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:collection';

import 'package:furhouse_app/models/petVM.dart';

class Pets {
  Future<String> add(PetVM pet) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("pets");

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

  Future<Map<String, PetVM>> getAllPets() async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("pets");
    Map<String, PetVM> petDataMap = <String, PetVM>{};

    try {
      var snapshot = await databaseRef.get();

      if (!snapshot.exists) {
        throw 'No available data!';
      }

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
    } catch (e) {
      rethrow;
    }
  }
}
