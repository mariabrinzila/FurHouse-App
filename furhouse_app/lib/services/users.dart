import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:furhouse_app/models/user_VM.dart';

class Users {
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<String> register(UserVM user) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      try {
        // authentication
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );

        // add user in the users collection
        DatabaseReference databaseReference = databaseRef.push();
        var key = databaseReference.key;

        await databaseReference.set({
          "key": key,
          "first_name": user.firstName,
          "last_name": user.lastName,
          "email": user.email,
          "birthday": user.birthday,
          "admin": user.admin,
        });
      } catch (e) {
        return e.toString();
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    try {
      // authentication
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> resetPassword(String userEmail) async {
    try {
      // send password reset email to user
      await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> getInformationForUser(
      String userEmail, String information) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      if (snapshot.value == null) {
        return "Success: ";
      }

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userInformation = "";

      for (var key in user.keys) {
        var userObject = user[key];

        userInformation = userObject[information];
      }

      return "Success:$userInformation";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateUserEmail(String newEmail, String password) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";
      var firstName = "";
      var lastName = "";
      var birthday = "";
      var admin = false;

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
        firstName = userObject["first_name"];
        lastName = userObject["last_name"];
        birthday = userObject["birthday"];
        admin = userObject["admin"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.set({
        "key": userKey,
        "first_name": firstName,
        "last_name": lastName,
        "email": newEmail,
        "birthday": birthday,
        "admin": admin,
      });

      try {
        final userCredential = EmailAuthProvider.credential(
          email: userEmail,
          password: password,
        );

        await currentUser
            ?.reauthenticateWithCredential(userCredential)
            .then((value) async {
          await currentUser.updateEmail(newEmail).then((value) async {
            await currentUser.reload();

            await FirebaseAuth.instance.signOut();
          }).catchError((error) {
            throw (error);
          });
        }).catchError((error) {
          throw (error);
        });
      } catch (e) {
        return e.toString();
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updatePassword(String newPassword, String password) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      try {
        final userCredential = EmailAuthProvider.credential(
          email: userEmail,
          password: password,
        );

        await currentUser
            ?.reauthenticateWithCredential(userCredential)
            .then((value) async {
          await currentUser.updatePassword(newPassword).then((value) async {
            await currentUser.reload();

            await FirebaseAuth.instance.signOut();
          }).catchError((error) {
            throw (error);
          });
        }).catchError((error) {
          throw (error);
        });
      } catch (e) {
        return e.toString();
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateBirthday(String newBirthday) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";
      var firstName = "";
      var lastName = "";
      var admin = false;

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
        firstName = userObject["first_name"];
        lastName = userObject["last_name"];
        admin = userObject["admin"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.set({
        "key": userKey,
        "first_name": firstName,
        "last_name": lastName,
        "email": userEmail,
        "birthday": newBirthday,
        "admin": admin,
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateFirstName(String newFirstName) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";
      var lastName = "";
      var birthday = "";
      var admin = false;

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
        lastName = userObject["last_name"];
        birthday = userObject["birthday"];
        admin = userObject["admin"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.set({
        "key": userKey,
        "first_name": newFirstName,
        "last_name": lastName,
        "email": userEmail,
        "birthday": birthday,
        "admin": admin,
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateLastName(String newLastName) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";
      var firstName = "";
      var birthday = "";
      var admin = false;

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
        firstName = userObject["first_name"];
        birthday = userObject["birthday"];
        admin = userObject["admin"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.set({
        "key": userKey,
        "first_name": firstName,
        "last_name": newLastName,
        "email": userEmail,
        "birthday": birthday,
        "admin": admin,
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> updateAdmin(String userEmail) async {
    try {
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";
      var firstName = "";
      var lastName = "";
      var birthday = "";

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
        firstName = userObject["first_name"];
        lastName = userObject["last_name"];
        birthday = userObject["birthday"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.set({
        "key": userKey,
        "first_name": firstName,
        "last_name": lastName,
        "email": userEmail,
        "birthday": birthday,
        "admin": true,
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> verifyEmail() async {
    try {
      var currentUser = getCurrentUser();

      // send verification email
      await currentUser?.sendEmailVerification();

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<void> checkIfEmailIsVerified() async {
    var currentUser = getCurrentUser();

    // reload user to catch any changes
    await currentUser?.reload();
  }

  Future<String> deleteAccount(String password) async {
    try {
      var currentUser = getCurrentUser();
      var userEmail = "";

      if (currentUser != null) {
        userEmail = currentUser.email ?? "";
      }

      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      var snapshot = await databaseRef
          .orderByChild("email")
          .equalTo(userEmail)
          .limitToFirst(1)
          .get();

      var user = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);
      var userKey = "";

      for (var key in user.keys) {
        var userObject = user[key];

        userKey = userObject["key"];
      }

      databaseRef = FirebaseDatabase.instance.ref().child("users/$userKey");

      await databaseRef.remove();

      try {
        final userCredential = EmailAuthProvider.credential(
          email: userEmail,
          password: password,
        );

        await currentUser
            ?.reauthenticateWithCredential(userCredential)
            .then((value) async {
          await currentUser.delete().catchError((error) {
            throw (error);
          });
        }).catchError((error) {
          throw (error);
        });
      } catch (e) {
        return e.toString();
      }

      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  Future<List<UserVM>> readUser(String userEmail) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("users");

    try {
      DataSnapshot snapshot =
          await databaseRef.orderByChild("email").equalTo(userEmail).get();

      if (!snapshot.exists) {
        throw "No available users!";
      }

      var usersList = await _mapDatabaseSnapshotToUserObject(snapshot, null);

      return usersList;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<UserVM>> _mapDatabaseSnapshotToUserObject(
      DataSnapshot snapshot, String? userEmail) async {
    List<UserVM> userDataList = <UserVM>[];

    var userData = Map<String, dynamic>.from(snapshot.value as LinkedHashMap);

    for (var key in userData.keys) {
      var userObject = userData[key];

      if (userEmail != null && userObject["email"] == userEmail) continue;

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

  Future<List<UserVM>> readAllUsers(String userEmail) async {
    DatabaseReference databaseRef =
        FirebaseDatabase.instance.ref().child("users");

    try {
      DataSnapshot snapshot = await databaseRef.get();

      if (!snapshot.exists) {
        throw "No available users!";
      }

      var usersList =
          await _mapDatabaseSnapshotToUserObject(snapshot, userEmail);

      return usersList;
    } catch (e) {
      rethrow;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
