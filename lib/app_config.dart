class AppConfig {
  static const String appMode = String.fromEnvironment(
    'APP_MODE',
    defaultValue: 'all',
  );

  static bool get showAll => appMode == 'all';
  static bool get isP1 => appMode == 'p1';
  static bool get isProject => appMode == 'project';

  // Helper to determine start route
  static String get initialRoute {
    if (isP1) return '/practices/p1';
    if (isProject) return '/project';
    return '/';
  }
}
