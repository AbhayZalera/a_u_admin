import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'add_vendor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyC1GpAEqSqYJXye00wSXP5JYTlYV74mAeg',
        appId: '1:612433370097:android:43caa4193ee008b40f0250',
        messagingSenderId: '612433370097',
        projectId: 'austore-4ffc3',
        storageBucket: 'austore-4ffc3.appspot.com',
      ));
  await FirebaseAppCheck.instance.activate();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //We are Using Getx So we have change this MaterialApp to GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "AU Admin",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            elevation: 0.0,
            backgroundColor: Colors.transparent),
        //fontFamily: regular,
      ),
      home: const AddVendorScreen(),
    );
  }
}
