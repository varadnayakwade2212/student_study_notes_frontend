import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService.initialize();

  final prefs = await SharedPreferences.getInstance();

  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final isDarkMode = prefs.getBool('isDarkMode') ?? true;

  runApp(
    StudyNotesApp(
      isLoggedIn: isLoggedIn,
      isDarkMode: isDarkMode,
    ),
  );
}

class StudyNotesApp extends StatefulWidget {
  final bool isLoggedIn;
  final bool isDarkMode;

  const StudyNotesApp({
    super.key,
    required this.isLoggedIn,
    required this.isDarkMode,
  });

  @override
  State<StudyNotesApp> createState() => _StudyNotesAppState();
}

class _StudyNotesAppState extends State<StudyNotesApp> {
  late bool isDarkMode;

  @override
  void initState() {
    super.initState();
    isDarkMode = widget.isDarkMode;
  }

  Future<void> changeTheme(bool value) async {
    setState(() {
      isDarkMode = value;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Study Notes',

      themeMode:
      isDarkMode ? ThemeMode.dark : ThemeMode.light,

      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),

      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor:
        const Color(0xFF2B2A28),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),

      home: widget.isLoggedIn
          ? HomeScreen(
        onThemeChanged: changeTheme,
      )
          : const LoginScreen(),
    );
  }
}