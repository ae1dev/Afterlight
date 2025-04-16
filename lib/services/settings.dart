import 'package:afterlight/main.dart';
import 'package:afterlight/models/favorite_app.dart';

class SettingsService {
  bool hapticFeedback = true;
  bool backgroundBlack = false;

  void setup() {
    hapticFeedback = box.get('hapticFeedback', defaultValue: true);
    backgroundBlack = box.get('backgroundBlack', defaultValue: false);
  }

  void setHapticFeedback(bool value) {
    hapticFeedback = value;
    box.put('hapticFeedback', value);
  }

  void setBackgroundBlack(bool value) {
    backgroundBlack = value;
    box.put('backgroundBlack', value);
  }

  // Create a backup
  Future<Map<String, dynamic>> createBackup() async {
    // Get favorite apps
    final List<dynamic> rawFavorites = box.get('favorites', defaultValue: []);
    List<FavoriteApp> favoriteApps = [];
    for (var element in rawFavorites) {
      favoriteApps.add(element);
    }

    return {
      "app": "Afterlight",
      "version": 1,
      "favorites": favoriteApps.map((e) => e.toJson()).toList(),
      "hapticFeedback": hapticFeedback,
      "backgroundBlack": backgroundBlack,
    };
  }

  Future<void> restoreBackup(Map<String, dynamic> backup) async {
    backgroundBlack = backup['backgroundBlack'];
    hapticFeedback = backup['hapticFeedback'];

    // Update settings
    setBackgroundBlack(backgroundBlack);
    setHapticFeedback(hapticFeedback);

    // Update favorites
    final List<dynamic> rawFavorites = backup['favorites'];
    List<FavoriteApp> favoriteApps = [];
    for (var element in rawFavorites) {
      favoriteApps.add(FavoriteApp.fromJson(element));
    }
    box.put('favorites', favoriteApps);
  }
}
