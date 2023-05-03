import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Authentication {
  Future<String> register({
    required String firstName,
    required String lastName,
    required String email,
    required String birthday,
    required String password,
  }) async {
    try {
      // authentication
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // add user in Realtime database
      DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');

      try {
        await databaseRef.set({
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "birthday": birthday,
        });
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
}
