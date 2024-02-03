import 'package:hive/hive.dart';

part 'hive_dark_mode.g.dart';

@HiveType(typeId: 2)
class HiveDarkMode {
  HiveDarkMode({required this.isDarkMode});
  @HiveField(0)
  bool isDarkMode;
}
