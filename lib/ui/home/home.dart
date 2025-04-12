import 'package:afterlight/services/apps.dart';
import 'package:afterlight/ui/settings/settings.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:apps_handler/apps_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    monitorApps();
    super.initState();
  }

  /// Monitor apps for changes
  void monitorApps() {
    AppsHandler.appChanges.listen((event) {
      switch (event.event) {
        case AppEventType.installed:
          print('App installed: ${event.packageName}');
          // Refresh apps
          ref.read(appServiceProvider.notifier).init();
          setState(() {});
          break;
        case AppEventType.uninstalled:
          print('App uninstalled: ${event.packageName}');
          // Remove app
          ref.read(appServiceProvider.notifier).removeApp(event.packageName);
          setState(() {});
          break;
        case AppEventType.updated:
          print('App updated: ${event.packageName}');
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        callHaptic();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsView()),
        );
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              ref.watch(appServiceProvider).favoriteApps.length,
              (index) => ListTile(
                title: Text(
                  ref.watch(appServiceProvider).favoriteApps[index].appName,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
