import 'package:flutter/material.dart';
import 'package:segundavuelta/logic/settings_logic.dart';
import 'package:segundavuelta/theme/app_theme.dart';
import 'package:segundavuelta/widgets/custom_app_bar.dart';
import 'package:segundavuelta/widgets/glass_card.dart';
import 'package:segundavuelta/widgets/gradient_background.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: 'Configuración'),
      body: GradientBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ValueListenableBuilder<ThemeMode>(
              valueListenable: SettingsLogic(),
              builder: (context, mode, child) {
                final isDark = mode == ThemeMode.dark;
                return Column(
                  children: [
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isDark ? Icons.dark_mode : Icons.light_mode,
                                color: isDark
                                    ? Colors.white
                                    : AppTheme.textDark,
                              ),
                              const SizedBox(width: 15),
                              Text(
                                "Modo Oscuro",
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge?.copyWith(fontSize: 18),
                              ),
                            ],
                          ),
                          Switch(
                            value: isDark,
                            activeColor: AppTheme.electricBlue,
                            onChanged: (value) {
                              SettingsLogic().toggleTheme(
                                !value,
                              ); // logic takes isLight
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
