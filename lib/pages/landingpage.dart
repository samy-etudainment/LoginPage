import 'package:flutter/material.dart';

class Landinpage extends StatefulWidget {
  const Landinpage({super.key});

  @override
  State<Landinpage> createState() => _LandinpageState();
}

class _LandinpageState extends State<Landinpage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    const String imageBackground = "assets/background.jpg";

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Don't have an account ?",
          style: TextStyle(color: Colors.white, fontSize: 30),
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
        ],
      ),
    );
  }
}
