import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/see_recipe_controller.dart';

class SeeRecipeView extends GetView<SeeRecipeController> {
  const SeeRecipeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SeeRecipeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SeeRecipeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
