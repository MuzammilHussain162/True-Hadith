import 'package:firebase_auth/firebase_auth.dart';
import 'api_service.dart';
import '../models/user_model.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign up a new user with Firebase and register in backend
  static Future<UserModel> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Create user in Firebase
      final UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Failed to create Firebase user');
      }

      final String firebaseUid = firebaseUser.uid;

      // Step 2: Register user in PostgreSQL backend
      final UserModel userModel = await ApiService.registerUser(
        firebaseUid: firebaseUid,
        username: name,
        email: email,
      );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Sign up failed: ${e.toString()}');
    }
  }

  /// Sign in existing user with Firebase and get user data from backend
  static Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      // Step 1: Sign in with Firebase
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw Exception('Failed to sign in');
      }

      final String firebaseUid = firebaseUser.uid;

      // Step 2: Get user data from PostgreSQL backend
      final UserModel userModel = await ApiService.loginUser(
        firebaseUid: firebaseUid,
      );

      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }
      throw Exception('Sign in failed: ${e.toString()}');
    }
  }

  /// Send password reset email
  static Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getFirebaseErrorMessage(e.code));
    } catch (e) {
      throw Exception('Failed to send password reset email: ${e.toString()}');
    }
  }

  /// Sign out current user
  static Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Get current Firebase user
  static User? getCurrentUser() {
    return _auth.currentUser;
  }

  /// Check if user is signed in
  static bool isSignedIn() {
    return _auth.currentUser != null;
  }

  /// Convert Firebase error codes to user-friendly messages
  static String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'An account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Please try again later.';
      case 'operation-not-allowed':
        return 'Signing in with Email and Password is not enabled.';
      default:
        return 'An error occurred: $code';
    }
  }
}

