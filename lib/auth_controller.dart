import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Observables and TextControllers
  var isLoading = false.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController(); // New controller for name

  // Firebase services
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign-Up method
  Future<UserCredential?> signupMethod({
    String? email,
    String? password,
    String? name,
    BuildContext? context,
  }) async {
    UserCredential? userCredential;
    try {
      isLoading(true); // Start loading
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      // Store user data in Firestore
      await storeUserData(
        name: name,
        email: email,
        userId: userCredential.user!.uid,
      );

      Get.snackbar('Success', 'Vendor added successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    } finally {
      isLoading(false); // Stop loading
    }
    return userCredential;
  }

  // Method to store user data in Firestore
  Future<void> storeUserData({
    String? name,
    String? email,
    String? userId,
    String? password
  }) async {
    DocumentReference store = _firestore.collection('vendors').doc(userId);
    await store.set({
      'vendor_name': name,
      'email': email,
      'id': userId,
      'imageUrl': '',
      'password': password
      //'created_at': FieldValue.serverTimestamp(),
    });
  }

// Sign-out method (if needed)
}
