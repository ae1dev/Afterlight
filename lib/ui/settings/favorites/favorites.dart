import 'package:afterlight/services/apps.dart';
import 'package:afterlight/utils/feedback.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:material_symbols_icons/symbols.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'FAVORITES',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(15),
              child: Text(
                'Mark apps as favorites to quickly access them on the home feed.',
              ),
            ),
          ),
          SliverList.builder(
            itemCount: ref.watch(appServiceProvider).apps.length,
            itemBuilder:
                (context, index) => ListTile(
                  title: Text(
                    ref.watch(appServiceProvider).apps[index].appName,
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      callHaptic();
                      try {
                        if (ref
                            .read(appServiceProvider.notifier)
                            .isFavorite(
                              ref
                                  .read(appServiceProvider)
                                  .apps[index]
                                  .packageName,
                            )) {
                          ref
                              .read(appServiceProvider.notifier)
                              .removeFavorite(
                                ref
                                    .read(appServiceProvider)
                                    .apps[index]
                                    .packageName,
                              );
                        } else {
                          ref
                              .read(appServiceProvider.notifier)
                              .addFavorite(
                                ref
                                    .read(appServiceProvider)
                                    .apps[index]
                                    .packageName,
                              );
                        }
                        setState(() {});
                      } catch (e) {
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text('Error'),
                                content: Text(e.toString()),
                              ),
                        );
                      }
                    },
                    icon: Icon(
                      Symbols.favorite_rounded,
                      fill:
                          ref
                                  .watch(appServiceProvider.notifier)
                                  .isFavorite(
                                    ref
                                        .read(appServiceProvider)
                                        .apps[index]
                                        .packageName,
                                  )
                              ? 1
                              : 0,
                    ),
                  ),
                ),
          ),
          SliverToBoxAdapter(child: Gap(100)),
        ],
      ),
    );
  }
}
