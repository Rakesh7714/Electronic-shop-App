import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {

  static Future<DocumentSnapshot>adminSignIn(id)async{
 var result = FirebaseFirestore.instance.collection('admin').doc(id).get();
 return result;
  }
  static Future<String?> CreateAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "email is already in use";
      }
      if (e.code == "weak-password") {
        return "password is too weak";
      }
    } catch (e) {
      return e.toString();
    }
  }

  static Future<String?> signInAccount(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  static Future<void> signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
