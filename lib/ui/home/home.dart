import 'package:afterlight/main.dart';
import 'package:afterlight/ui/settings/settings.dart';
import 'package:apps_handler/apps_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gaimon/gaimon.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
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
          appsService.init();
          setState(() {});
          break;
        case AppEventType.uninstalled:
          print('App uninstalled: ${event.packageName}');
          // Remove app
          appsService.removeApp(event.packageName);
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
        Gaimon.selection();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsView()),
        );
      },
      child: Scaffold(
        body: ListView.builder(
          itemCount: appsService.apps.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(appsService.apps[index].appName),
              onTap: () {
                Gaimon.selection();
                AppsHandler.openApp(appsService.apps[index].packageName);
              },
            );
          },
        ),
      ),
    );
  }
}
