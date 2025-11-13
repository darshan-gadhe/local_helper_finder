import 'package:flutter/material.dart';
import 'package:locallinker/models/user_model.dart';
import 'package:locallinker/services/firestore_service.dart';

// An enum to represent the different states of our data
enum UserStatus { Uninitialized, Loading, Loaded, Error }

class UserProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  UserModel? _user;
  UserStatus _status = UserStatus.Uninitialized;
  String _errorMessage = '';

  // Getters for the UI to read the state
  UserModel? get user => _user;
  UserStatus get status => _status;
  String get errorMessage => _errorMessage;

  Future<void> fetchUserData(String uid) async {
    // Set status to loading and notify listeners
    _status = UserStatus.Loading;
    notifyListeners();

    try {
      final doc = await _firestoreService.getUserData(uid);
      if (doc.exists) {
        _user = UserModel.fromFirestore(doc);
        _status = UserStatus.Loaded; // Data loaded successfully
      } else {
        _errorMessage = "User data not found in the database.";
        _status = UserStatus.Error; // Error state
      }
    } catch (e) {
      _errorMessage = "An error occurred: ${e.toString()}";
      _status = UserStatus.Error; // Error state
      print(_errorMessage); // For debugging
    }

    // Notify listeners of the final state
    notifyListeners();
  }

  void clearUser() {
    _user = null;
    _status = UserStatus.Uninitialized;
    notifyListeners();
  }
}