import 'package:afterlight/main.dart';
import 'package:afterlight/models/favorite_app.dart';
import 'package:apps_handler/apps_handler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apps.freezed.dart';

class AppsService extends StateNotifier<AppState> {
  AppsService() : super(const AppState());

  // Initialize
  Future<void> init() async {
    // Get apps
    state = state.copyWith(
      apps: await AppsHandler.getInstalledApps(
        includeSystemApps: false,
        includeAppIcons: true,
        onlyAppsWithLaunchIntent: true,
      ),
    );

    // Get favorites
    final List<dynamic> rawFavorites = box.get('favorites', defaultValue: []);
    for (var element in rawFavorites) {
      state = state.copyWith(favorites: [...state.favorites, element]);
    }

    // Remove Afterlight
    state.apps.removeWhere((app) => app.packageName == 'dev.ae1.afterlight');

    // Sort apps by name
    state.apps.sort((a, b) => a.appName.compareTo(b.appName));

    // Get favorites
    state = state.copyWith(
      favoriteApps:
          state.apps
              .where(
                (app) => state.favorites
                    .map((e) => e.packageName)
                    .contains(app.packageName),
              )
              .toList(),
    );
  }

  // Remove app
  void removeApp(String packageName) {
    state = state.copyWith(
      apps: state.apps.where((app) => app.packageName != packageName).toList(),
    );
  }

  // Add favorite
  void addFavorite(String packageName) {
    state = state.copyWith(
      favorites: [
        ...state.favorites,
        FavoriteApp(
          packageName: packageName,
          placement: state.favorites.length,
        ),
      ],
    );
    state = state.copyWith(
      favoriteApps: [
        ...state.favoriteApps,
        state.apps.firstWhere((app) => app.packageName == packageName),
      ],
    );
  }

  // Remove favorite
  void removeFavorite(String packageName) {
    state = state.copyWith(
      favorites:
          state.favorites
              .where((app) => app.packageName != packageName)
              .toList(),
    );
    state = state.copyWith(
      favoriteApps:
          state.favoriteApps
              .where((app) => app.packageName != packageName)
              .toList(),
    );
  }

  bool isFavorite(String packageName) {
    return state.favorites.map((e) => e.packageName).contains(packageName);
  }
}

@freezed
abstract class AppState with _$AppState {
  const factory AppState({
    /// The apps
    @Default([]) List<dynamic> apps,

    /// The favorite apps
    @Default([]) List<dynamic> favoriteApps,

    /// The favorites
    @Default([]) List<dynamic> favorites,
  }) = _AppState;
}

// Create providers
final appServiceProvider = StateNotifierProvider<AppsService, AppState>((ref) {
  return AppsService();
});
