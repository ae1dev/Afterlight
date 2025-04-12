import 'package:afterlight/services/apps.dart';
import 'package:afterlight/ui/home/home.dart';
import 'package:afterlight/ui/widgets/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    try {
      // Get apps
      await ref.read(appServiceProvider.notifier).init();

      // Navigate to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeView()),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder:
            (context) =>
                AlertDialog(title: Text('Error'), content: Text(e.toString())),
      );
    }
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
