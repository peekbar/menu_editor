import 'package:get/get.dart';
import 'package:menu_editor/controllers/menus_controller.dart';
import 'package:menu_editor/models/food_category.dart';
import 'package:menu_editor/models/imprint.dart';
import 'package:menu_editor/models/info_banner.dart';
import 'package:menu_editor/models/language.dart';
import 'package:menu_editor/models/menu.dart';
import 'package:menu_editor/models/minimum_order.dart';
import 'package:menu_editor/models/opening_hours.dart';
import 'package:menu_editor/models/product.dart';
import 'package:uuid/uuid.dart';

class EditorController extends GetxController {
  final _menusController = Get.find<MenusController>();

  // menu
  final id = ''.obs;
  final title = ''.obs;
  final language = Language.en.obs;
  final foodCategories = <FoodCategory>[].obs;
  final infoBanners = <InfoBanner>[].obs;
  final openingHours = <OpeningHours>[].obs;
  final minimumOrders = <MinimumOrder>[].obs;
  final imprint = Imprint(
    id: const Uuid().v4(),
    holder: 'PEEKBAR',
    street: 'Street 1',
    city: 'City 1',
    phone: '0123456789',
    mail: 'mail@peekbar.de',
    tax: 'DE01234XX',
    homepage: 'peekbar.de',
    companyName: 'PEEKBAR',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    var arg = Get.arguments;
    if (arg is Menu) {
      id.value = arg.id;
      title.value = arg.title;
      language.value = arg.language;
      foodCategories.assignAll(arg.categories);
      infoBanners.assignAll(arg.banners);
      minimumOrders.assignAll(arg.minimumOrders);
      imprint.value = arg.imprint;
    }
  }

  void addTo(Product product, FoodCategory foodCategory) {
    foodCategory.products.add(product);
    update();
  }

  // void updateCategory(FoodCategory foodCategory) {
  //   foodCategories[foodCategory.id] = foodCategory;
  //   update();
  // }

  void delete(FoodCategory foodCategory) {
    foodCategories.removeWhere((element) => element.id == foodCategory.id);
    update();
  }

  void deleteProductFrom(Product product, FoodCategory foodCategory) {
    foodCategory.products.removeWhere((p) => p.id == product.id);
    update();
  }

  Future<void> save() async => await _menusController.addOrOverride(
        Menu(
          id: id.isEmpty ? const Uuid().v4() : id.value,
          editedAt: DateTime.now(),
          title: title.value,
          language: language.value,
          categories: foodCategories,
          banners: infoBanners,
          openingHours: openingHours,
          minimumOrders: minimumOrders,
          imprint: imprint.value,
        ),
      );
}
