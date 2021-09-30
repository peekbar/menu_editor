import 'package:get/get.dart';
import 'package:menu_editor/controllers/menus_controller.dart';
import 'package:menu_editor/models/menu.dart';

class ExistingMenusController extends GetxController {
  final _menusController = Get.find<MenusController>();

  final loading = false.obs;
  final menus = <Menu>[];

  @override
  void onInit() {
    loading.value = _menusController.loading.value;
    menus.assignAll(_menusController.menus);
    _menusController.loading.listen((l) => loading.value = l);
    _menusController.menus.listen(menus.assignAll);
    super.onInit();
  }

  Future<void> delete(Menu menu) async {
    await _menusController.deleteBy(menu.id);
    update();
  }

  Future<void> duplicate(Menu menu) async {
    await _menusController.duplicate(menu);
    update();
  }
}
