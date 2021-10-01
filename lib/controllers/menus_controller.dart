import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:menu_editor/models/menu.dart';

class MenusController extends GetxController {
  final _storage = GetStorage();

  final loading = false.obs;
  final menus = <Menu>[].obs;

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
    menus.removeWhere((m) => m.id == menu.id);
    menus.add(menu);
    await _writeCurrentMenus();
  }

  Future<void> duplicate(Menu menu) async {
    menus.add(menu.copy());
    await _writeCurrentMenus();
  }

  Future<void> _writeCurrentMenus() async => _storage.write(_StorageKeys.menus, menus.map((m) => m.toJson()).toList());
}

class _StorageKeys {
  _StorageKeys._();

  static const menus = 'menus';
}
