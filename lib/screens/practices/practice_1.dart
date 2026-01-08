import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class Practice1Screen extends StatelessWidget {
  const Practice1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Práctica 1: Hola'),
      body: GradientBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                duration: const Duration(seconds: 1),
                child: const Icon(
                  Icons.sentiment_satisfied_alt,
                  size: 100,
                  color: AppTheme.electricBlue,
                ),
              ),
              const SizedBox(height: 30),
              FadeInUp(
                duration: const Duration(seconds: 1),
                child: Text(
                  '¡Hola, Flutter!',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontSize: 40,
                    shadows: [
                      BoxShadow(
                        color: AppTheme.electricBlue.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              FadeInUp(
                delay: const Duration(milliseconds: 500),
                child: Text(
                  'Bienvenido al futuro.',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
