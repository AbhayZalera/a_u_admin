// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'auth_controller.dart'; // Ensure you import the AuthController
//
// class AddVendorScreen extends StatefulWidget {
//   const AddVendorScreen({Key? key}) : super(key: key);
//
//   @override
//   _AddVendorScreenState createState() => _AddVendorScreenState();
// }
//
// class _AddVendorScreenState extends State<AddVendorScreen> {
//   // Controllers for form fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//
//   // Firebase services
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//   // Form Key
//   final _formKey = GlobalKey<FormState>();
//
//   // Instance of AuthController
//   final AuthController _authController = Get.put(AuthController());
//
//   // Method to add vendor
//   Future<void> _addVendor() async {
//     if (_formKey.currentState!.validate()) {
//       try {
//         _authController.isLoading(true); // Start loading
//
//         // Create vendor user in FirebaseAuth
//         UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//           email: _emailController.text.trim(),
//           password: _passwordController.text.trim(),
//         );
//
//         // Add vendor details to Firestore
//         await _firestore.collection('vendors').doc(userCredential.user!.uid).set({
//           'vendor_name': _nameController.text.trim(),
//           'email': _emailController.text.trim(),
//           'id': userCredential.user!.uid,
//           'password': _passwordController.text.trim(),
//           'imageUrl': ""
//           //'created_at': FieldValue.serverTimestamp(),
//         });
//
//         // Show success message and clear form
//         Get.snackbar('Success', 'Vendor added successfully',
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);
//
//         _nameController.clear();
//         _emailController.clear();
//         _passwordController.clear();
//       } on FirebaseAuthException catch (e) {
//         Get.snackbar('Error', e.message.toString(),
//             snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
//       } finally {
//         _authController.isLoading(false); // Stop loading
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blueAccent,
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: const Text('Add Vendor'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Vendor Name Field
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(
//                   labelText: 'Vendor Name',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter the vendor name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//
//               // Vendor Email Field
//               TextFormField(
//                 controller: _emailController,
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an email address';
//                   }
//                   if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//                     return 'Please enter a valid email address';
//                   }
//                   return null;
//                 },
//                 keyboardType: TextInputType.emailAddress,
//               ),
//               const SizedBox(height: 16.0),
//
//               // Vendor Password Field
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                   filled: true,
//                   fillColor: Colors.white,
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a password';
//                   }
//                   if (value.length < 6) {
//                     return 'Password must be at least 6 characters long';
//                   }
//                   return null;
//                 },
//                 obscureText: true,
//               ),
//               const SizedBox(height: 32.0),
//
//               // Add Vendor Button
//               Obx(() {
//                 return ElevatedButton(
//                   onPressed: _authController.isLoading.value ? null : _addVendor,
//                   style: ElevatedButton.styleFrom(
//                     minimumSize: const Size(double.infinity, 50), // Full width button
//                   ),
//                   child: _authController.isLoading.value
//                       ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator
//                       : const Text('Add Vendor'),
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_controller.dart'; // Ensure you import the AuthController

class AddVendorScreen extends StatefulWidget {
  const AddVendorScreen({Key? key}) : super(key: key);

  @override
  _AddVendorScreenState createState() => _AddVendorScreenState();
}

class _AddVendorScreenState extends State<AddVendorScreen> {
  // Controllers for form fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Firebase services
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Form Key
  final _formKey = GlobalKey<FormState>();

  // Instance of AuthController
  final AuthController _authController = Get.put(AuthController());

  // Method to add vendor
  Future<void> _addVendor() async {
    if (_formKey.currentState!.validate()) {
      try {
        _authController.isLoading(true); // Start loading

        // Create vendor user in FirebaseAuth
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        // Add vendor details to Firestore
        await _firestore.collection('vendors').doc(userCredential.user!.uid).set({
          'vendor_name': nameController.text.trim(),
          'email': emailController.text.trim(),
          'id': userCredential.user!.uid,
          'password': passwordController.text.trim(),
          'imageUrl': ""
          //'created_at': FieldValue.serverTimestamp(),
        });

        // Show success message and clear form
        Get.snackbar('Success', 'Vendor added successfully',
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.green, colorText: Colors.white);

        nameController.clear();
        emailController.clear();
        passwordController.clear();
      } on FirebaseAuthException catch (e) {
        Get.snackbar('Error', e.message.toString(),
            snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.red, colorText: Colors.white);
      } finally {
        _authController.isLoading(false); // Stop loading
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Add Vendor'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Vendor Name Field
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Vendor Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the vendor name';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16.0),

                    // Vendor Email Field
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email address';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),

                    // Vendor Password Field
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    const SizedBox(height: 32.0),

                    // Add Vendor Button
                    Obx(() {
                      return ElevatedButton(
                        onPressed: _authController.isLoading.value ? null : _addVendor,
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blueAccent, // Full width button
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _authController.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white) // Show loading indicator
                            : const Text('Add Vendor', style: TextStyle(fontSize: 18)),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
