import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:furhouse_app/models/petVM.dart';

class Pets {
  Future<String> add(PetVM pet) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("pets");

      // add pet in the pets collection
      await databaseRef.push().set({
        "name": pet.name,
        "cateogory": pet.category,
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
}
