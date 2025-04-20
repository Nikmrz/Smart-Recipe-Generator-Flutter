import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_pantry_controller.dart';

class MyPantryView extends GetView<MyPantryController> {
  const MyPantryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyPantryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyPantryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
