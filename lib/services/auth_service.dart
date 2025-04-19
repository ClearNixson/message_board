import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign up with email and password
  Future<User?> signUp(String email, String password, String firstName, String lastName) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      
      // Add user to Firestore
      await _firestore.collection('users').doc(result.user?.uid).set({
        'uid': result.user?.uid,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': 'user',
        'registrationDateTime': DateTime.now(),
      });
      
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign in with email and password
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>> getUserData(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc.data() as Map<String, dynamic>;
  }

  // Update user profile
  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _firestore.collection('users').doc(uid).update(data);
  }
}