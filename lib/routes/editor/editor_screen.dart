import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/models/food_category.dart';
import 'package:menu_editor/models/product.dart';
import 'package:menu_editor/routes/editor/editor_controller.dart';
import 'package:menu_editor/themes/theme_colors.dart';
import 'package:uuid/uuid.dart';

class EditorScreen extends GetView<EditorController> {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('editor menus'),
          automaticallyImplyLeading: false,
          leading: IconButton(
            tooltip: 'Back',
            onPressed: () async {
              var close = await Get.dialog<bool?>(
                AlertDialog(
                  title: const Text('Alert'),
                  content: const Text('Do you really want close the editor? Your current changes won\'t be saved.'),
                  actions: [
                    TextButton(onPressed: () => Get.back(result: true), child: const Text('YES')),
                    TextButton(onPressed: () => Get.back(result: false), child: const Text('NO')),
                  ],
                ),
              );
              if (close == true) Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          actions: [
            IconButton(
              onPressed: () => controller.save().then((value) => Get.back()),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Obx(() => Column(
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Material(
                          color: ThemeColors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {},
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'edit title',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: Material(
                          color: ThemeColors.grey,
                          borderRadius: BorderRadius.circular(8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.0),
                            onTap: () {},
                            child: const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  'edit imprint',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16.0),
                    ],
                  ),
                  if (controller.foodCategories.isEmpty) ...[
                    const SizedBox(height: 16.0),
                    const _AddCategoryButton(),
                  ] else
                    Column(
                      children: [
                        const SizedBox(height: 16.0),
                        for (var i = 0; i < controller.foodCategories.length; i++) ...[
                          _FoodCategoryView(
                            foodCategory: controller.foodCategories[i],
                          ),
                          const SizedBox(height: 8.0),
                        ],
                        const _AddCategoryButton(),
                      ],
                    ),
                  const SizedBox(height: 16.0),
                ],
              )),
        ),
      );
}

class _FoodCategoryView extends StatelessWidget {
  final FoodCategory foodCategory;

  const _FoodCategoryView({Key? key, required this.foodCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: ThemeColors.grey,
            borderRadius: BorderRadius.circular(8.0),
            child: GetBuilder<EditorController>(
                builder: (controller) => Column(
                      children: [
                        const SizedBox(height: 16.0),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('name: ${foodCategory.name}'),
                                    Text('icon: ${foodCategory.icon}'),
                                  ],
                                ),
                              ),
                              IconButton(
                                onPressed: () => Get.find<EditorController>().delete(foodCategory),
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                        if (foodCategory.products.isEmpty) ...[
                          const SizedBox(height: 16.0),
                          _AddProductButton(foodCategory: foodCategory),
                        ] else
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Table(
                                  columnWidths: const {
                                    0: FlexColumnWidth(),
                                    1: FlexColumnWidth(),
                                    2: FlexColumnWidth(2),
                                    3: FlexColumnWidth(),
                                    4: FlexColumnWidth(2),
                                  },
                                  children: [
                                    const TableRow(
                                      children: [
                                        Text('Name'),
                                        Text('Shortname'),
                                        Text('Description'),
                                        Text('Price'),
                                        Text('Add'),
                                      ],
                                    ),
                                    for (var i = 0; i < foodCategory.products.length; i++)
                                      TableRow(children: [
                                        Text('${foodCategory.products[i].name}'),
                                        Text('${foodCategory.products[i].shortName}'),
                                        Text('${foodCategory.products[i].description}'),
                                        Text('${foodCategory.products[i].price}'),
                                        Text('${foodCategory.products[i].additives}')
                                      ]),
                                  ],
                                ),
                                // for (var i = 0; i < foodCategory.products.length; i++) ...[
                                //   _ProductView(foodCategory: foodCategory, product: foodCategory.products[i]),
                                //   const Divider(height: 2.0, color: Colors.black),
                                // ],
                                const SizedBox(height: 8.0),
                                _AddProductButton(foodCategory: foodCategory),
                                const SizedBox(height: 8.0),
                              ],
                            ),
                          ),
                      ],
                    )),
          ),
        ),
      );
}

class _ProductView extends StatelessWidget {
  final FoodCategory foodCategory;
  final Product product;

  const _ProductView({Key? key, required this.foodCategory, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('name: ${product.name}'),
                  Text('shortname: ${product.shortName}'),
                  Text('description: ${product.description}'),
                  Text('price: ${product.price}'),
                  Text('additives: ${product.additives}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () => Get.find<EditorController>().deleteProductFrom(product, foodCategory),
              icon: const Icon(Icons.delete),
            ),
          ],
        ),
      );
}

class _AddCategoryButton extends StatelessWidget {
  const _AddCategoryButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: 'New Category',
        onPressed: () {
          Get.find<EditorController>().foodCategories.add(
                FoodCategory(
                  id: const Uuid().v4(),
                  name: 'New Category',
                  icon: '',
                  products: [],
                ),
              );
        },
        icon: const Icon(Icons.add),
      );
}

class _AddProductButton extends StatelessWidget {
  final FoodCategory foodCategory;

  const _AddProductButton({Key? key, required this.foodCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: 'New Product',
        onPressed: () => Get.find<EditorController>().addTo(
          Product(
            id: const Uuid().v4(),
            name: 'New Product',
            shortName: '1',
            description: 'Description',
            price: '1 Euro',
            additives: '',
          ),
          foodCategory,
        ),
        icon: const Icon(Icons.add),
      );
}
