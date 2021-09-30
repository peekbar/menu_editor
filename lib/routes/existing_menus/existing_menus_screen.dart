import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/models/menu.dart';
import 'package:menu_editor/navigation/navigation.dart';
import 'package:menu_editor/routes/existing_menus/existing_menus_controller.dart';
import 'package:menu_editor/themes/text_styles.dart';
import 'package:menu_editor/themes/theme_colors.dart';

class ExistingMenusScreen extends StatelessWidget {
  const ExistingMenusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('existing menus')),
        body: SingleChildScrollView(
          child: GetBuilder<ExistingMenusController>(
              builder: (controller) => Column(
                    children: [for (var menu in controller.menus) _MenuPreview(menu: menu)],
                  )),
        ),
      );
}

class _MenuPreview extends StatelessWidget {
  final Menu menu;

  const _MenuPreview({Key? key, required this.menu}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            color: ThemeColors.grey,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(menu.title),
                      const SizedBox(height: 8.0),
                      Row(
                        children: [
                          Text(menu.id, style: TextStyles.caption),
                          const SizedBox(width: 8.0),
                          Text(menu.editedAt.toIso8601String(), style: TextStyles.caption),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  tooltip: 'Duplicate',
                  onPressed: () => Get.find<ExistingMenusController>().duplicate(menu),
                  icon: const Icon(Icons.copy),
                ),
                IconButton(
                  tooltip: 'Delete',
                  onPressed: () => Get.find<ExistingMenusController>().delete(menu),
                  icon: const Icon(Icons.clear),
                ),
                IconButton(
                  tooltip: 'Edit',
                  onPressed: () => Get.toNamed(Navigation.editor, arguments: menu),
                  icon: const Icon(Icons.edit),
                ),
              ],
            ),
          ),
        ),
      );
}
