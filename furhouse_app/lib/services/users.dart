import 'dart:collection';

import 'package:firebase_database/firebase_database.dart';

import 'package:furhouse_app/models/user_VM.dart';

class Users {
  Future<List<UserVM>> getAllUsers() async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("users");

    try {
      DataSnapshot snapshot = await databaseRef.get();

      if (!snapshot.exists) {
        throw "No available users!";
      }

      var usersList = await _mapDatabaseSnapshotToUserObject(snapshot);

      return usersList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserVM>> _mapDatabaseSnapshotToUserObject(
      DataSnapshot snapshot) async {
    List<UserVM> userDataList = <UserVM>[];

    var userData = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);

    for (var key in userData.keys) {
      var userObject = userData[key];

      var currentUser = UserVM(
        firstName: userObject["first_name"],
        lastName: userObject["last_name"],
        email: userObject["email"],
        birthday: userObject["birthday"],
        password: "",
        admin: userObject["admin"],
      );

      currentUser.id = userObject["key"];

      userDataList.add(currentUser);
    }

    return userDataList;
  }
}
