import 'package:hive/hive.dart';

part 'hive_fav.g.dart';

@HiveType(typeId: 1)
class HiveFav {
  HiveFav({
    required this.id,
    required this.web340,
    required this.isSafe,
  });

  @HiveField(0)
  int id;

  @HiveField(1)
  String web340;

  @HiveField(2)
  bool isSafe;
}
