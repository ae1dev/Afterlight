import 'package:afterlight/ui/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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
      home: const HomeView(),
    );
  }
}
