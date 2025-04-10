import 'package:get/get.dart';

import '../../../models/recipe.dart';

class RecipeDetailController extends GetxController {
  late Recipe recipe;

  @override
  void onInit() {
    recipe = Get.arguments;
    super.onInit();
  }
}
