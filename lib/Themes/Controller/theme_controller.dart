import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../themes.dart';

class ThemesController extends GetxController {
  late ThemeData currentTheme;
  late ThemeMode currentMode;

  Future toggleTheme() async {
    const storage = FlutterSecureStorage();

    if (currentTheme == AppThemes.darkTheme) {
      currentTheme = AppThemes.lightTheme;
      await storage.write(key: "theme", value: "light");
    } else {
      currentTheme = AppThemes.darkTheme;
      await storage.write(key: "theme", value: "dark");
    }
    Get.changeThemeMode(
        currentTheme == AppThemes.darkTheme ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  bool getThemeFlag = false;
  Future getThemeMode() async {
    getThemeFlag = true;
    ThemeMode mode = ThemeMode.system;
    const storage = FlutterSecureStorage();
    if (await storage.containsKey(key: "theme")) {
      String? theme = await storage.read(key: "theme");
      if (theme != null) {
        currentTheme =
            theme == "dark" ? AppThemes.darkTheme : AppThemes.lightTheme;
        if (theme == "dark") {
          await storage.write(key: "theme", value: "dark");
        } else {
          await storage.write(key: "theme", value: "light");
        }

        mode = theme == "dark" ? ThemeMode.dark : ThemeMode.light;
      } else {
        currentTheme = AppThemes.lightTheme;
        mode = ThemeMode.light;
        await storage.write(key: "theme", value: "light");
      }
    }

    getThemeFlag = false;
    currentMode = mode;
    update();
  }
}
