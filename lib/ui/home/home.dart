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
                          const Gap(8),
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
                                    'All Apps',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
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
                        );
                      },
                    ),
                  ],
                ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          // Swipe up
          _showAllAppsDrawer();
        }
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
                onTap: () async {
                  callHaptic();
                  await AppsHandler.openApp(
                    ref
                        .read(appServiceProvider)
                        .favoriteApps[index]
                        .packageName,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
