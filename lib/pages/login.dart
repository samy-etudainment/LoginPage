import 'package:flutter/material.dart';
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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  static const String imageBackground = "assets/background.jpg";
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

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
                        "Sign up !",
                        style: TextStyle(
                          fontSize: width * 0.09,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 30, left: 30, top: 30),
                      height: 70,
                      width: width,
                      child: TextField(
                        enableSuggestions: false,
                        controller: _emailController,
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
                          margin: const EdgeInsets.only( left: 30),
                          height: 70,
                          child:  Text(
                            "Don't have an account ?",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const Signup());
                          },
                          child: Container(
                            margin: const EdgeInsets.only( left: 5),
                            height: 70,
                            child:  Text(
                              "Sign up !",
                              style: TextStyle(
                                  color: Colors.deepOrangeAccent.shade100,
                                  fontSize: 15,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 40),
                    RoundedLoadingButton(
                      errorColor: Colors.redAccent,
                      resetDuration: const Duration(milliseconds: 1250),
                      color: Colors.deepOrangeAccent.shade100,
                      successColor:  Colors.deepOrangeAccent,
                      controller: _btnController,
                      onPressed: () {
                        setState(() async {
                          await Future.delayed(const Duration(milliseconds: 0));
                          _btnController.success();
                          await Future.delayed(
                            const Duration(milliseconds: 1750),
                          );
                          _btnController.reset();
                          const Duration(milliseconds: 500);
                          Get.offAll(() => const Landinpage());
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
