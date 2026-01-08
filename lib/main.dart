import 'package:flutter/material.dart';
import 'package:segundavuelta/app_config.dart';
import 'package:segundavuelta/logic/settings_logic.dart';
import 'package:segundavuelta/theme/app_theme.dart';

// Screens
import 'package:segundavuelta/screens/hub_screen.dart';
import 'package:segundavuelta/screens/settings_screen.dart';
import 'package:segundavuelta/screens/practices/practices_screen.dart';
import 'package:segundavuelta/screens/practices/practice_1.dart';
import 'package:segundavuelta/screens/practices/practice_2.dart';
import 'package:segundavuelta/screens/practices/practice_page_view.dart';
import 'package:segundavuelta/screens/project/project_menu.dart';
import 'package:segundavuelta/screens/project/modules/notes_screen.dart';
import 'package:segundavuelta/screens/project/modules/bmi_screen.dart';
import 'package:segundavuelta/screens/project/modules/gallery_screen.dart';
import 'package:segundavuelta/screens/project/modules/parity_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: SettingsLogic(),
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Segunda Vuelta',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: mode,
          initialRoute: AppConfig.initialRoute,
          routes: {
            '/': (context) => const HubScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/practices': (context) => const PracticesScreen(),
            '/practices/p1': (context) => const Practice1Screen(),
            '/practices/p2': (context) => const Practice2Screen(),
            '/practices/p3': (context) =>
                const Practice3PageView(maxVisiblePractice: 3),
            '/practices/p4': (context) =>
                const Practice3PageView(maxVisiblePractice: 4),
            '/practices/p5': (context) =>
                const Practice3PageView(maxVisiblePractice: 5),
            '/project': (context) => const ProjectMenuScreen(),
            '/project/notes': (context) => const NotesScreen(),
            '/project/bmi': (context) => const BmiScreen(),
            '/project/gallery': (context) => const GalleryScreen(),
            '/project/parity': (context) => const ParityScreen(),
          },
        );
      },
    );
  }
}
