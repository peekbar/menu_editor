import 'dart:convert';
import 'dart:io';

import 'package:dart_console/dart_console.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_clt/classes/generator.dart';
import 'package:menu_clt/classes/local_file_helper.dart';
import 'package:menu_editor/file_handler.dart';
import 'package:menu_editor/models/menu.dart';

class MenusController extends GetxController {
  final _storage = GetStorage();

  final loading = false.obs;
  final menus = <Menu>[].obs;
  var nonce = 1.obs;

  @override
  Future<void> onInit() async {
    await preInit();
    super.onInit();
  }

  Future<void> preInit() async {
    loading.value = true;
    await GetStorage.init();
    var stored = _storage.read(_StorageKeys.menus);
    if (stored == null) {
      loading.value = false;
      return;
    }
    var menuStrings = stored;
    for (var menuString in menuStrings) {
      menus.add(Menu.fromJson(menuString));
    }
    loading.value = false;
  }

  // MARK - functions

  Future<void> overrideMenu(Menu menu) async {}

  Future<void> deleteBy(String id) async {
    menus.removeWhere((m) => m.id == id);
    await _writeCurrentMenus();
  }

  Future<void> addOrOverride(Menu menu) async {
    print(menu.openingHours.toString());
    menus.removeWhere((m) => m.id == menu.id);
    menus.add(menu);
    nonce.value = nonce.value + 1;
    await _writeCurrentMenus();
  }

  Future<void> duplicate(Menu menu) async {
    menus.add(menu.copy());
    await _writeCurrentMenus();
  }

  Future<void> _writeCurrentMenus() async => _storage.write(_StorageKeys.menus, menus.map((m) => m.toJson()).toList());

  Future<void> importMenu() async {
    var importedString = await FileHandler.getFileAsString();
    if (importedString != '') {
      try {
        var importedMenu = Menu.fromJson(jsonDecode(importedString));
        print(importedMenu.imprint.companyName);
        var alreadyImported = menus.where((m) => m.id == importedMenu.id);
        if (alreadyImported.isNotEmpty) {
          await Get.dialog<bool?>(AlertDialog(
            title: const Text('Alert'),
            content: const Text('Override the already existing menu?'),
            actions: [
              TextButton(
                  onPressed: () => {addOrOverride(importedMenu), Get.back()}, child: const Text('Yes, override')),
              TextButton(onPressed: () => {Get.back()}, child: const Text('NO, cancel import')),
            ],
          ));
        }
        print(alreadyImported.first.editedAt);
      } catch (e) {
        await Get.dialog(AlertDialog(
          title: const Text('Import failed'),
          content: const Text('The file contains not a valid menu!'),
          actions: [TextButton(onPressed: Get.back, child: const Text('OK, got it.'))],
        ));
      }
    }
  }

  Future<void> exportMenu(Menu menu) async {
    await FileHandler.saveStringAs(
        '${menu.imprint.companyName.toLowerCase()}_${menu.editedAt.day}.${menu.editedAt.month}.${menu.editedAt.year}.json',
        jsonEncode(menu.toJson()));
  }

  Future<void> generateMenu(Menu menu) async {
    var source = await findLastUsedTemplate();
    var success = true;

    if (source != null) {
      await Get.dialog(AlertDialog(
        title: const Text('Use previous template'),
        content: const Text('Do you want to use the previously selected template again?'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('Yes')),
          TextButton(onPressed: () => {Get.back(), source = null}, child: const Text('No, select different'))
        ],
      ));
    }

    if (source == null) {
      String name;
      String? destination;
      await FileHandler.getDirectory('Select a template Folder').then((value) async => {
        // copy template to ApplicationLocationDirectory, to circumvent access right issues on application restart
            if (value != null)
              {
                name = value.split('/').last,
                destination = await FileHandler.createDirectory(
                    await FileHandler.getApplicationLocationTemplateDirectory(), name),
                LocalFileHelper().copyAllFilesTo(destination!, value)
              },
            source = destination
          });
    }

    if (source != null) {
      await setLastUsedTemplate(source!);
      var destination = await FileHandler.getDirectory('Destination for the generated website');

      if (destination != null) {
        destination = await FileHandler.createDirectory(destination, menu.title);
        LocalFileHelper().copyAllFilesTo(destination!, source!);
        success = await Generator(Console()).generateFrom(destination, jsonEncode(menu.toJson()));
      }
    }
    if (!success) {
      await Get.dialog(AlertDialog(
        title: const Text('Website generation failed.'),
        content: const Text('Please check the template for correctness.'),
        actions: [TextButton(onPressed: Get.back, child: const Text('OK, got it.'))],
      ));
    }
    ;
  }

  Future<String?> findLastUsedTemplate() async {
    await GetStorage.init();

    var template = _storage.read(_StorageKeys.template);
    if (template != null && !await Directory(template).exists()) {
      return null;
    }
    // used to check for permissions
    try {
      Directory(template).listSync();
    } catch (e) {
      return null;
    }
    return template;
  }

  Future<void> setLastUsedTemplate(String pathToTemplateDirectory) async {
    await _storage.write(_StorageKeys.template, pathToTemplateDirectory);
  }
}

class _StorageKeys {
  _StorageKeys._();

  static const menus = 'menus';
  static const template = 'template';
}
