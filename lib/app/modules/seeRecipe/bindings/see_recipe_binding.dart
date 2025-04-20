import 'package:get/get.dart';

import '../controllers/see_recipe_controller.dart';

class SeeRecipeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SeeRecipeController>(
      () => SeeRecipeController(),
    );
  }
}
