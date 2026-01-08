import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class PracticesScreen extends StatelessWidget {
  const PracticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Índice de Prácticas'),
      body: GradientBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildPracticeItem(context, 'P1: Hola Mundo', '/practices/p1', 1),
              _buildPracticeItem(context, 'P2: Generador', '/practices/p2', 2),
              _buildPracticeItem(
                context,
                'P3: Acumulativo (P1+P2)',
                '/practices/p3',
                3,
              ),
              _buildPracticeItem(
                context,
                'P4: Acumulativo (P1+P2+P4)',
                '/practices/p4',
                4,
              ),
              _buildPracticeItem(
                context,
                'P5: Cumulative (All)',
                '/practices/p5',
                5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPracticeItem(
    BuildContext context,
    String title,
    String route,
    int index,
  ) {
    return FadeInLeft(
      delay: Duration(milliseconds: 100 * index),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GestureDetector(
          onTap: () => Navigator.pushNamed(context, route),
          child: GlassCard(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.electricBlue.withOpacity(0.2),
                  child: Text(
                    'P$index',
                    style: const TextStyle(
                      color: AppTheme.electricBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
