import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_profile.dart';

class AuthUserProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  UserProfile? _userProfile;
  bool _isLoading = false;

  User? get user => _user;
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;

  AuthUserProvider() {
    _auth.authStateChanges().listen((User? u) async {
      _user = u;
      if (u != null) {
        await fetchUserProfile(u.uid);
      }
      notifyListeners();
    });
  }

  Future<bool> signInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      _user = userCredential.user;

      if (_user != null) {
        bool isExist = await checkUserExists(_user!.uid);
        _isLoading = false;
        notifyListeners();
        return isExist;
      }
    } catch (e) {
      print("Auth Error: $e");
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> checkUserExists(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.exists;
  }

  Future<void> fetchUserProfile(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      _userProfile = UserProfile.fromMap(doc.data() as Map<String, dynamic>);
      notifyListeners();
    }
  }

  Future<bool> createUserProfile(UserProfile profile) async {
    try {
      await _firestore
          .collection('users')
          .doc(profile.uid)
          .set(profile.toMap());
      _userProfile = profile;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    _user = null;
    _userProfile = null;
    notifyListeners();
  }
}
