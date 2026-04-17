import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:login_page/models/auth_firebase.dart';
import 'package:login_page/pages/login.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';

class Landinpage extends StatefulWidget {
  const Landinpage({super.key});

  @override
  State<Landinpage> createState() => _LandinpageState();
}

class _LandinpageState extends State<Landinpage> {
  final AuthController authController = Get.find<AuthController>();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void logOut() async {
    try {
      await authController.signOut();
      _btnController.success();
      await Future.delayed(const Duration(milliseconds: 1750));
      Get.offAll(() => const Login());
    } on FirebaseAuthException catch (e) {
      _btnController.error();
      _btnController.reset();
      print("MISY ERREUR EEEEEEEEE");
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const String imageBackground = "assets/background.jpg";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade100,
        title: Text(
          "Welcome",
          style: TextStyle(color: Colors.black, fontSize: 30),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageBackground),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: RoundedLoadingButton(
              errorColor: Colors.redAccent,
              resetDuration: const Duration(milliseconds: 1250),
              color: Colors.deepOrangeAccent.shade100,
              successColor: Colors.deepOrangeAccent,
              controller: _btnController,
              onPressed: () {
                setState(() {
                  logOut();
                });
              },
              child: Text(
                "Log Out",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
