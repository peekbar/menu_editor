import 'package:get/get.dart';
import 'package:menu_editor/routes/editor/editor_controller.dart';
import 'package:menu_editor/routes/editor/editor_screen.dart';
import 'package:menu_editor/routes/existing_menus/existing_menus_controller.dart';
import 'package:menu_editor/routes/existing_menus/existing_menus_screen.dart';
import 'package:menu_editor/routes/overview/overview_controller.dart';
import 'package:menu_editor/routes/overview/overview_screen.dart';
import 'package:menu_editor/routes/settings/settings_controller.dart';
import 'package:menu_editor/routes/settings/settings_screen.dart';

class Navigation {
  Navigation._();

  static final pages = <GetPage>[
    GetPage(
      name: editor,
      page: () => const EditorScreen(),
      binding: BindingsBuilder.put(() => EditorController()),
    ),
    GetPage(
      name: exitsting_menus,
      page: () => const ExistingMenusScreen(),
      binding: BindingsBuilder.put(() => ExistingMenusController()),
    ),
    GetPage(
      name: overview,
      page: () => const OverviewScreen(),
      binding: BindingsBuilder.put(() => OverviewController()),
    ),
    GetPage(
      name: settings,
      page: () => const SettingsScreen(),
      binding: BindingsBuilder.put(() => SettingsController()),
    ),
  ];

  static const editor = '/editor';
  static const exitsting_menus = '/existing-menus';
  static const overview = '/overview';
  static const settings = '/settings';
}
