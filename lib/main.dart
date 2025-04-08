import 'package:afterlight/services/apps.dart';
import 'package:afterlight/ui/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

AppsService appsService = AppsService();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Afterlight',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Color.fromARGB(255, 4, 9, 24),
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
    );
  }
}
