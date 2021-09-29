import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:menu_editor/navigation/navigation.dart';

class OverviewScreen extends StatelessWidget {
  const OverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Overview')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('What do you want to accomplish today?'),
              const SizedBox(height: 32.0),
              ElevatedButton(
                child: const Text('Edit saved menu'),
                onPressed: () => Get.toNamed(Navigation.exitsting_menus),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                child: const Text('Create new menu'),
                onPressed: () => Get.toNamed(Navigation.editor),
              ),
            ],
          ),
        ),
      );
}
