import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/models/food_category.dart';
import 'package:menu_editor/models/imprint.dart';
import 'package:menu_editor/models/minimum_order.dart';
import 'package:menu_editor/models/opening_hours.dart';
import 'package:menu_editor/models/product.dart';
import 'package:menu_editor/models/weekday.dart';
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
                    TextButton(
                        onPressed: () => {Get.back(result: true), controller.discardChanges()},
                        child: const Text('YES')),
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
                  Center(
                    child: Text('Title'),
                  ),
                  Center(
                      child: SizedBox(
                          width: 200, child: EditableTextField(controller.title, (p0) => {controller.title = p0}))),
                  ImprintView(controller.imprint.value),
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
                  _OpeningHoursView(controller.openingHours),
                  const SizedBox(height: 16.0),
                  _MinimumOrderView(controller.minimumOrders),
                  const SizedBox(height: 16.0),
                ],
              )),
        ),
      );
}

class ImprintView extends StatelessWidget {
  const ImprintView(this.imprint, {Key? key}) : super(key: key);

  final Imprint imprint;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SizedBox(
          width: double.infinity,
          child: Material(
            color: ThemeColors.grey,
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {0: IntrinsicColumnWidth(), 1: IntrinsicColumnWidth(), 2: FlexColumnWidth()},
                children: [
                  createRow('Firmenname', imprint.companyName, (value) => imprint.companyName = value),
                  createRow('Inhaber', imprint.holder, (value) => imprint.holder = value),
                  createRow('Straße', imprint.street, (value) => imprint.street = value),
                  createRow('Stadt', imprint.city, (value) => imprint.city = value),
                  createRow('Mail', imprint.mail, (value) => imprint.mail = value),
                  createRow('Telefon', imprint.phone, (value) => imprint.phone = value),
                  createRow('Steuernummer', imprint.tax, (value) => imprint.tax = value),
                ],
              ),
            ),
          ),
        ),
      );

  TableRow createRow(String lableText, String editableText, Function(String) saveValue) => TableRow(
        children: [
          Text(lableText),
          SizedBox(
            width: 30,
          ),
          EditableTextField(editableText, saveValue),
        ],
      );
}

class EditableTextField extends StatelessWidget {
  String editableText;
  Function(String) saveValue;

  EditableTextField(this.editableText, this.saveValue, {Key? key}) : super(key: key) {
    _textFieldController.text = editableText;
    _textFieldController.addListener(() {
      saveValue(_textFieldController.text);
    });
    _focusNode.addListener(() {
      _textFieldController.selection = TextSelection(baseOffset: 0, extentOffset: _textFieldController.text.length);
    });
  }

  TextEditingController _textFieldController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: TextField(
          decoration: const InputDecoration(
              fillColor: ThemeColors.grey,
              focusColor: ThemeColors.primaryTransparent,
              filled: true,
              border: OutlineInputBorder(borderSide: BorderSide(color: ThemeColors.primaryTransparent, width: 10)),
              enabledBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: ThemeColors.primaryTransparent, width: 2)),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: ThemeColors.primary, width: 3))),
          controller: _textFieldController,
          autofocus: true,
          focusNode: _focusNode,
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
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: IntrinsicColumnWidth(),
                                    1: FixedColumnWidth(30),
                                    2: FlexColumnWidth()
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        Text('Kategorie'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        EditableTextField(foodCategory.name, (p0) => foodCategory.name = p0),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        Text('Icon'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        EditableTextField(foodCategory.icon, (p0) => foodCategory.icon = p0),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment: Alignment.topCenter,
                                child: IconButton(
                                  onPressed: () => Get.find<EditorController>().delete(foodCategory),
                                  icon: const Icon(Icons.delete),
                                ),
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
                                    1: FixedColumnWidth(10),
                                    2: FlexColumnWidth(),
                                    3: FixedColumnWidth(10),
                                    4: FlexColumnWidth(2),
                                    5: FixedColumnWidth(10),
                                    6: FlexColumnWidth(2),
                                    7: FixedColumnWidth(10),
                                    8: FlexColumnWidth()
                                  },
                                  children: [
                                    const TableRow(
                                      children: [
                                        Text('Name'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Shortname'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Description'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Price'),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text('Add'),
                                      ],
                                    ),
                                    const TableRow(children: [
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                    ]),
                                    for (var i = 0; i < foodCategory.products.length; i++)
                                      TableRow(children: [
                                        EditableTextField(
                                            foodCategory.products[i].name, (p0) => foodCategory.products[i].name = p0),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        EditableTextField(foodCategory.products[i].shortName,
                                            (p0) => foodCategory.products[i].shortName = p0),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        EditableTextField(foodCategory.products[i].description,
                                            (p0) => foodCategory.products[i].description = p0),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        EditableTextField(foodCategory.products[i].price,
                                            (p0) => foodCategory.products[i].price = p0),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        EditableTextField(foodCategory.products[i].additives,
                                            (p0) => foodCategory.products[i].additives = p0),
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

class _OpeningHoursView extends StatelessWidget {
  _OpeningHoursView(this.openingHoursList, {Key? key}) ;

  final List<OpeningHours> openingHoursList;
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(child: Text('Opening Hours'))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FlexColumnWidth(),
                                    1: FixedColumnWidth(30),
                                    2: IntrinsicColumnWidth()
                                  },
                                  children: [
                                    const TableRow(
                                      children: [
                                        Text('Days'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('Hours')
                                      ],
                                    ),
                                    for (var i = 0; i < openingHoursList.length; i++)
                                      TableRow(children: [
                                        ExpandableNotifier(
                                          child: Column(
                                            children: [
                                              Expandable(
                                                collapsed: ExpandableButton(
                                                child: Row(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.centerLeft,
                                                    child: Icon(Icons.expand_more),
                                                ),
                                                Text(WeekdayString.weekdayListToString(openingHoursList[i].days))
                                                  ],
                                                )),
                                                expanded: Column(children: [
                                                  ExpandableButton(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.expand_less),
                                                        Text(WeekdayString.weekdayListToString(openingHoursList[i].days))
                                                      ],
                                                    ),
                                                  ),
                                                  for (var day in Weekday.values)
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Checkbox(
                                                            value: openingHoursList[i].days.contains(day),
                                                            onChanged: (value) => {
                                                             
                                                                  if (value!) {
                                                                    openingHoursList[i].days.add(day),
                                                                  } else {
                                                                    openingHoursList[i].days.remove(day)
                                                                  },
                                                              
                                                                  controller.update()
                                                                }),
                                                        Text(WeekdayString.weekdayToString(day)),
                                                      ],
                                                    ),
                                                ]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        EditableTextField(openingHoursList[i].hours, (p0) => openingHoursList[i].hours = p0)
                                        
                                      ])
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        _AddOpeningHoursButton()
                      ],
                    )),
          ),
        ),
      );
}

class _MinimumOrderView extends StatelessWidget {
  _MinimumOrderView(this.minimumOrderList, { Key? key }) : super(key: key);

  List<MinimumOrder> minimumOrderList;
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
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Center(child: Text('Minimum Order'))),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Table(
                                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                                  columnWidths: {
                                    0: FlexColumnWidth(),
                                    1: FixedColumnWidth(30),
                                    2: FlexColumnWidth()
                                  },
                                  children: [
                                    const TableRow(
                                      children: [
                                        Text('Distance'),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('Order Value')
                                      ],
                                    ),
                                    for (var i = 0; i < minimumOrderList.length; i++)
                                      TableRow(children: [
                                        EditableTextField(minimumOrderList[i].distance, (p0) => minimumOrderList[i].distance = p0),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        EditableTextField(minimumOrderList[i].order, (p0) => minimumOrderList[i].order = p0),
                                        
                                      ])
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        _AddMinimumOrderButton()
                      ],
                    )),
          ),
        ),
      );
  }

class _AddOpeningHoursButton extends StatelessWidget {
  const _AddOpeningHoursButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: 'New Opening Hour Entry',
        onPressed: () {
          Get.find<EditorController>()
              .addOpeningHours(OpeningHours(id: const Uuid().v4(), days: {Weekday.monday}, hours: '00:00 - 00:00'));
        },
        icon: const Icon(Icons.add),
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
        onPressed: () => Get.find<EditorController>().addProductTo(
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

class _AddMinimumOrderButton extends StatelessWidget {
  const _AddMinimumOrderButton({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
        tooltip: 'New Opening Hour Entry',
        onPressed: () {
          Get.find<EditorController>()
              .addMinimumOrder(MinimumOrder(id: const Uuid().v4(), distance: '5km', order: '20 Euro'));
        },
        icon: const Icon(Icons.add),
      );
}
