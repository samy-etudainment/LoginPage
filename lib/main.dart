import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:login_page/models/auth_firebase.dart';
import 'package:login_page/pages/components/card_around.dart';
import 'package:login_page/pages/landingpage.dart';
import 'package:login_page/pages/login.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_page/pages/splash_screen.dart';
import 'firebase_options.dart';
import 'package:get_storage/get_storage.dart';

void main  () async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const Authentificationcheck(),
    );
  }
}

class Authentificationcheck extends StatelessWidget {
  const Authentificationcheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData) {
          return const Landinpage();
        }
        return const SplashScreen();
      },
    );
  }
}
