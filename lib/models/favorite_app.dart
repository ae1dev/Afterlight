import 'package:hive_ce/hive.dart';

@HiveType(typeId: 1)
class FavoriteApp extends HiveObject {
  @HiveField(0)
  String packageName;

  @HiveField(1)
  int placement;

  FavoriteApp({required this.packageName, required this.placement});

  FavoriteApp.fromJson(Map<String, dynamic> json)
    : packageName = json['packageName'],
      placement = json['placement'];

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'placement': placement,
  };
}
