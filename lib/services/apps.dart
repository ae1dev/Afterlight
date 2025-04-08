import 'package:apps_handler/apps_handler.dart';

class AppsService {
  List<AppInfo> apps = [];

  Future<void> init() async {
    // Get apps
    apps = await AppsHandler.getInstalledApps(
      includeSystemApps: false,
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: true,
    );

    // Sort apps by name
    apps.sort((a, b) => a.appName.compareTo(b.appName));
  }
}
