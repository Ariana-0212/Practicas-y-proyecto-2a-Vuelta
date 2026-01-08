import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Determine gradient colors based on theme
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final gradientColors = isDark
        ? [
            const Color(0xFF000000), // Deep Black
            const Color(0xFF0A0A1A), // Dark Blue-ish
            const Color(0xFF150020), // Dark Purple-ish
          ]
        : [
            const Color(0xFFF5F5FA), // Light Background
            const Color(0xFFE0E0FF), // Light Blue-ish
            const Color(0xFFF0E0FF), // Light Purple-ish
          ];

    final orbColor1 = isDark
        ? const Color(0xFF00E5FF)
        : const Color(0xFF0055FF);
    final orbColor2 = isDark
        ? const Color(0xFFD500F9)
        : const Color(0xFFAA00FF);

    return Stack(
      children: [
        // Base background
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
          ),
        ),
        // Subtle glowing orbs
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: orbColor1.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: orbColor1.withOpacity(0.15),
                  blurRadius: 150,
                  spreadRadius: 50,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: orbColor2.withOpacity(0.15),
              boxShadow: [
                BoxShadow(
                  color: orbColor2.withOpacity(0.15),
                  blurRadius: 150,
                  spreadRadius: 50,
                ),
              ],
            ),
          ),
        ),
        // Content
        child,
      ],
    );
  }
}
