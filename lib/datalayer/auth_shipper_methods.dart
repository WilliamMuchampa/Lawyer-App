import 'package:advocatus/datalayer/shipper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthShipperMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserDetails?> getShipperUserDetails() async {
    User userCred = _auth.currentUser!;

    final snap = await _firestore.collection("users").doc(userCred.uid).get();

    return UserDetails.fromJson(snap.data());
  }

  Future<String?> getShipperData() async {
    final shipperSnapshot =
        await _firestore.collection("users").doc(_auth.currentUser?.uid).get();
    final shipperData = shipperSnapshot.data();

    // Access the values from the shipperData map
    String? id = shipperData?['id'];

    return id;
  }

  Future<String> registerShipperUser({
    required String userName,
    required String phoneNumber,
    required String email,
    required String password,
    required bool lawyer,
  }) async {
    String res = "some error occurred";
    try {
      if (userName.isNotEmpty ||
          phoneNumber.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        final shippers = UserDetails(
            id: cred.user!.uid,
            userName: userName,
            phoneNumber: phoneNumber,
            email: cred.user!.email,
            lawyer: lawyer);

        await FirebaseFirestore.instance
            .collection('users')
            .doc(cred.user!.uid)
            .set(shippers.toJson());

        res = "successfully";
      }
    } /* on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  } */

    catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<String> loginShipperUser({
    required String email,
    required String password,
  }) async {
    String res = "some error occured";

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);

        res = "successfully";
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  Future<void> shipperLogout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e.toString();
    }
  }
}
