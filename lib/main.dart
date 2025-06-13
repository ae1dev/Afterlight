import 'package:afterlight/models/hive_registrar.g.dart';
import 'package:afterlight/services/settings.dart';
import 'package:afterlight/ui/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

late Box box;
SettingsService settingsService = SettingsService();

void main() async {
  // Initialize Hive
  await Hive.initFlutter();
  Hive.registerAdapters();
  box = await Hive.openBox('afterlightBox');

  // Setup settings
  settingsService.setup();

  // Run the app
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box(
        'afterlightBox',
      ).listenable(keys: ['backgroundBlack']),
      builder: (context, lBox, w) {
        return MaterialApp(
          title: 'Afterlight',
          theme: ThemeData(
            primaryColor: Color.fromARGB(255, 3, 174, 236),
            colorScheme: ColorScheme.fromSeed(
              seedColor: Color.fromARGB(255, 3, 174, 236),
              brightness: Brightness.dark,
            ),
            fontFamily: 'Stratum2',
            scaffoldBackgroundColor:
                lBox.get('backgroundBlack', defaultValue: false)
                    ? Colors.black
                    : Color.fromARGB(255, 4, 9, 24),
            brightness: Brightness.dark,
          ),
          debugShowCheckedModeBanner: false,
          home: const SplashView(),
        );
      },
    );
  }
}
