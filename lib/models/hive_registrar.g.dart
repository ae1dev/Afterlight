// Generated by Hive CE
// Do not modify
// Check in to version control

import 'package:hive_ce/hive.dart';
import 'package:afterlight/models/favorite_app.dart';
import 'package:afterlight/models/hive_adapters.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(FavoriteAppAdapter());
    registerAdapter(FavoriteAppAdapter());
  }
}
