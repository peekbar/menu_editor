import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/controllers/menus_controller.dart';
import 'package:menu_editor/menu_editor.dart';
import 'package:window_size/window_size.dart' as window_size;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await preAppInit();
  runApp(const MenuEditor());
}

Future<void> preAppInit() async {
  setWindowSize();
  Get.put(MenusController(), permanent: true);
}

void setWindowSize() {
  window_size.getWindowInfo().then((window) {
    final screen = window.screen;
    if (screen != null) {
      final screenFrame = screen.visibleFrame;
      final width = math.min(screenFrame.width, 1000.0);
      final height = math.min(screenFrame.height, 1000.0);
      final left = ((screenFrame.width - width) / 2).roundToDouble();
      final top = ((screenFrame.height - height) / 3).roundToDouble();
      final frame = Rect.fromLTWH(left, top, width, height);
      window_size.setWindowMinSize(Size(width, height));
      window_size
          .setWindowTitle('Menu Editor');
      window_size.setWindowFrame(frame);
    }
  });
}
