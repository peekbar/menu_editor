import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/controllers/menus_controller.dart';
import 'package:menu_editor/menu_editor.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preAppInit();
  runApp(const MenuEditor());
}

Future<void> preAppInit() async {
  Get.put(MenusController(), permanent: true);
}
