import 'package:ahmedadmin/helpers/auth_exception.dart';
import 'package:ahmedadmin/models/app_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    Provider<AuthenticationService>((ref) => AuthenticationService());

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign in with email and password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getAuthExceptionMessage(e.code));
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Register with email and password
  Future<User?> registerWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user, email);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getAuthExceptionMessage(e.code));
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<void> _saveUserToFirestore(User user, String email) async {
    final appUser = AppUser(
      userId: user.uid,
      role: 'sales',
      name: '',
      email: email,
    );
    await _firestore.collection('users').doc(user.uid).set(appUser.toJson());
  }

  // Sign out the current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  String _getAuthExceptionMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      default:
        return 'An unknown error occurred.';
    }
  }

  get currentUser => FirebaseAuth.instance.currentUser!.uid;
}
