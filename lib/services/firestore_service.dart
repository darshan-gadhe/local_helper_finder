import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  // Save user data
  Future<void> saveUserData(String uid, String name, String email) {
    return _usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'createdAt': Timestamp.now(),
    });
  }

  // Get user data
  Future<DocumentSnapshot> getUserData(String uid) {
    return _usersCollection.doc(uid).get();
  }
}