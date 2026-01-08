import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class ProjectMenuScreen extends StatelessWidget {
  const ProjectMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Módulos del Proyecto'),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              children: [
                _buildProjectCard(
                  context,
                  'Notas',
                  Icons.notes,
                  '/project/notes',
                  0,
                ),
                _buildProjectCard(
                  context,
                  'Calc IMC',
                  Icons.health_and_safety,
                  '/project/bmi',
                  1,
                ),
                _buildProjectCard(
                  context,
                  'Galería',
                  Icons.photo_library,
                  '/project/gallery',
                  2,
                ),
                _buildProjectCard(
                  context,
                  'Paridad',
                  Icons.numbers,
                  '/project/parity',
                  3,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
    BuildContext context,
    String title,
    IconData icon,
    String route,
    int index,
  ) {
    return FadeInUp(
      delay: Duration(milliseconds: 200 * index),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: AppTheme.electricBlue),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
