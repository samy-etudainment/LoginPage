import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login_page/models/auth_firebase.dart';
import 'package:login_page/pages/signup.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:get/get.dart';
import 'landingpage.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController authController = Get.find<AuthController>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static const String imageBackground = "assets/background.jpg";
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<Map<String, dynamic>?> getUserDataByUID(String uid) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance
          .collection("user_info")
          .doc(uid)
          .get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data();
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  void login() async {
    try {
      await authController.login(
        email: _emailController.text,
        password: _passwordController.text,
      );
      String userName = "";
      String userEmail = _emailController.text.trim();
      final querySnapshot = await FirebaseFirestore.instance
          .collection("user_info")
          .where("email", isEqualTo: userEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        userName = querySnapshot.docs.first.data()['name'] ?? '';
      }

      _btnController.success();
      await Future.delayed(const Duration(milliseconds: 1750));
      _btnController.reset();

      print(userName);
      Get.offAll(
        () => const Landinpage(),
        arguments: {'userName': userName, 'userEmail': userEmail},
      );
    } on FirebaseAuthException {
      _btnController.error();
      await Future.delayed(const Duration(milliseconds: 1750));
      _btnController.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Stack(
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
              SafeArea(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.3),
                    Container(
                      alignment: Alignment.center,
                      height: 50,
                      width: width,
                      child: Text(
                        "Let's login !",
                        style: TextStyle(
                          fontSize: width * 0.09,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        right: 30,
                        left: 30,
                        top: 30,
                      ),
                      height: 70,
                      width: width,
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                          enableSuggestions: false,
                          controller: _emailController,
                          cursorErrorColor: Colors.blueAccent,
                          validator: (value) {
                            if (value!.isEmpty) return 'Please add your e-mail';
                            final emailRegex = RegExp(
                              r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$',
                            );
                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: "E-mail",
                            labelStyle: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 30),
                      height: 70,
                      width: MediaQuery.sizeOf(context).width,
                      child: TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                          border: UnderlineInputBorder(),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 30),
                          height: 70,
                          child: Text(
                            "Don't have an account ?",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Signup());
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 5),
                            height: 70,
                            child: Text(
                              "Sign up !",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.deepOrangeAccent.shade100,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    RoundedLoadingButton(
                      errorColor: Colors.redAccent,
                      resetDuration: const Duration(milliseconds: 1250),
                      color: Colors.deepOrangeAccent.shade100,
                      successColor: Colors.deepOrangeAccent,
                      controller: _btnController,
                      onPressed: () {
                        setState(() {
                          if (formKey.currentState!.validate()) {
                            login();
                          } else {
                            _btnController.reset();
                          }
                        });
                      },
                      child: Text(
                        "Continue",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
