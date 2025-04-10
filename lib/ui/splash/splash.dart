import 'package:afterlight/main.dart';
import 'package:afterlight/ui/home/home.dart';
import 'package:afterlight/ui/widgets/icon.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    // Get apps
    await appsService.init();

    // Navigate to home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeView()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconWidget(size: 250, color: Theme.of(context).primaryColor),
      ),
    );
  }
}
