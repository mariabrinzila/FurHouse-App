import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:furhouse_app/models/userVM.dart';

class Authentication {
  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }

  Future<String> register(UserVM user) async {
    try {
      // add user in Realtime database
      DatabaseReference databaseRef =
          FirebaseDatabase.instance.ref().child("users");

      try {
        await databaseRef.push().set({
          "first_name": user.firstName,
          "last_name": user.lastName,
          "email": user.email,
          "birthday": user.birthday,
          "admin": user.admin,
        });

        // authentication
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );
      } catch (e) {
        return e.toString();
      }

      return 'Success';
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

      return 'Success';
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
