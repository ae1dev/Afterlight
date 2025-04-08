import 'package:apps_handler/apps_handler.dart';

class AppsService {
  List<AppInfo> apps = [];

  Future<void> init() async {
    apps = await AppsHandler.getInstalledApps(
      includeSystemApps: false,
      includeAppIcons: true,
      onlyAppsWithLaunchIntent: true,
    );
  }
}
