import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Panel Principal',
        showBack: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () => Navigator.pushNamed(context, '/settings'),
          ),
        ],
      ),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'Bienvenido',
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FadeInDown(
                  delay: const Duration(milliseconds: 200),
                  duration: const Duration(milliseconds: 800),
                  child: Text(
                    'Selecciona un módulo para continuar',
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(color: Colors.white70),
                  ),
                ),
                const SizedBox(height: 40),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 1,
                    mainAxisSpacing: 20,
                    childAspectRatio: 1.8,
                    children: [
                      _buildDashboardCard(
                        context,
                        title: 'Prácticas',
                        subtitle: 'Accede a las prácticas aisladas',
                        icon: Icons.code,
                        color: AppTheme.electricBlue,
                        onTap: () => Navigator.pushNamed(context, '/practices'),
                        delay: 400,
                      ),
                      _buildDashboardCard(
                        context,
                        title: 'Proyecto',
                        subtitle: 'Módulos completos del proyecto',
                        icon: Icons.rocket_launch,
                        color: AppTheme.neonPurple,
                        onTap: () => Navigator.pushNamed(context, '/project'),
                        delay: 600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required int delay,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: delay),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(icon, size: 150, color: color.withOpacity(0.1)),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(icon, color: color, size: 32),
                    ),
                    const Spacer(),
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subtitle,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
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
