import 'dart:math';
import 'package:flutter/material.dart';

class OrbitImagesWidget extends StatefulWidget {
  const OrbitImagesWidget({super.key});

  @override
  State<OrbitImagesWidget> createState() => _OrbitImagesWidgetState();
}

class _OrbitImagesWidgetState extends State<OrbitImagesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  final List<String> images = [
    "assets/LOGO_TURBO_FILL.png",
    "assets/LOGO_TURBO_FILL.png",
    "assets/LOGO_TURBO_FILL.png",
    "assets/LOGO_TURBO_FILL.png",
    "assets/LOGO_TURBO_FILL.png"
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double orbitRadiusX = 130;
    const double orbitRadiusY = 75;

    return SizedBox(
      width: 320,
      height: 320,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Center Icon
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.deepOrangeAccent.shade100,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20,
                      spreadRadius: 2,
                      color: Colors.black.withAlpha(5),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  color: Colors.black,
                  size: 42,
                ),
              ),

              ...List.generate(images.length, (index) {
                final double baseAngle =
                    (2 * pi / images.length) * index;

                final double angle =
                    baseAngle + controller.value * 2 * pi;

                final double x = cos(angle) * orbitRadiusX;
                final double y = sin(angle) * orbitRadiusY;

                final double depth =
                    (sin(angle) + 1) / 2; // 0 to 1
                final double scale =
                    0.65 + (depth * 0.55);
                final double opacity =
                    0.45 + (depth * 0.55);

                return Transform.translate(
                  offset: Offset(x, y),
                  child: Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: Container(
                        width: 58,
                        height: 58,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.deepOrangeAccent.shade100,
                            width: 2,
                          ),
                          image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 10,
                              color: Colors.black.withAlpha(2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}