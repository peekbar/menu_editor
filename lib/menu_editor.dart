import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/navigation/navigation.dart';
import 'package:menu_editor/themes/themes.dart';

/// The application.
class MenuEditor extends StatelessWidget {
  const MenuEditor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        title: 'Menu Editor by PEEKBAR',
        theme: Themes.dark,
        getPages: Navigation.pages,
        initialRoute: Navigation.overview,
      );
}
