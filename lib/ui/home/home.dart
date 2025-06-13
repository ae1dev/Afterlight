import 'package:afterlight/services/apps.dart';
import 'package:afterlight/ui/settings/settings.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:apps_handler/apps_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  bool _validDrag = false;

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
          // Refresh apps
          ref.read(appServiceProvider.notifier).init();
          break;
        case AppEventType.uninstalled:
          // Remove app
          ref.read(appServiceProvider.notifier).removeApp(event.packageName);
          break;
        case AppEventType.updated:
          break;
      }
    });
  }

  void _showAllAppsDrawer() {
    callHaptic();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.5,
            maxChildSize: 0.95,
            expand: false,
            builder:
                (context, scrollController) => CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          const Gap(15),
                          Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[600],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const Gap(20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'ALL APPS',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    callHaptic();
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SettingsView(),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Symbols.settings_rounded),
                                ),
                              ],
                            ),
                          ),
                          const Gap(10),
                        ],
                      ),
                    ),
                    SliverList.builder(
                      itemCount: ref.watch(appServiceProvider).apps.length,
                      itemBuilder: (context, index) {
                        final app = ref.watch(appServiceProvider).apps[index];
                        return ListTile(
                          title: Text(app.appName),
                          onTap: () async {
                            callHaptic();
                            await AppsHandler.openApp(app.packageName);
                          },
                          onLongPress: () {
                            callHaptic();
                            _showAppInfBottomSheet(app);
                          },
                        );
                      },
                    ),
                  ],
                ),
          ),
    );
  }

  void _showAppInfBottomSheet(AppInfo app) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        bool isFavorite = ref
            .read(appServiceProvider.notifier)
            .isFavorite(app.packageName);

        return Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Text(app.appName, style: const TextStyle(fontSize: 20)),
              const Gap(10),
              const Divider(),
              ListTile(
                title: Text(
                  isFavorite ? 'Remove from favorites' : 'Add to favorites',
                ),
                onTap: () {
                  callHaptic();
                  if (isFavorite) {
                    ref
                        .read(appServiceProvider.notifier)
                        .removeFavorite(app.packageName);
                  } else {
                    ref
                        .read(appServiceProvider.notifier)
                        .addFavorite(app.packageName);
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('App Info'),
                onTap: () {
                  callHaptic();
                  Navigator.pop(context);
                  AppsHandler.openAppSettings(app.packageName);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onVerticalDragStart: (details) {
            // Check if the drag is valid (not a swipe up from the navbar)
            if ((constraints.maxHeight - details.globalPosition.dy) > 80) {
              _validDrag = true;
            }
          },
          onVerticalDragEnd: (details) {
            // Check if the drag is valid then show the drawer
            if (details.primaryVelocity! < 0 && _validDrag) {
              // Swipe up
              _showAllAppsDrawer();
            }

            _validDrag = false;
          },
          child: Scaffold(
            body: Center(child: SingleChildScrollView(child: buildList())),
          ),
        );
      },
    );
  }

  Widget buildList() {
    //No favorite apps
    if (ref.watch(appServiceProvider).favoriteApps.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add apps to your favorites to show up here.',
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: () {
                callHaptic();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SettingsView()),
                );
              },
              child: Text('Open Settings'),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        ref.watch(appServiceProvider).favoriteApps.length,
        (index) {
          AppInfo app = ref.watch(appServiceProvider).favoriteApps[index];

          return ListTile(
            title: Text(app.appName),
            onTap: () async {
              callHaptic();
              await AppsHandler.openApp(app.packageName);
            },
            onLongPress: () {
              callHaptic();
              _showAppInfBottomSheet(app);
            },
          );
        },
      ),
    );
  }
}
