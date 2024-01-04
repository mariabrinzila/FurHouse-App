import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:furhouse_app/models/user_VM.dart';

class Authentication {
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
        await databaseRef.push().set({
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

  Future<String> updateUserEmail(String newEmail) async {
    try {
      return "Success";
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      return e.toString();
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }
}
