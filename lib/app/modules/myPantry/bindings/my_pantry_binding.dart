import 'package:get/get.dart';

import '../controllers/my_pantry_controller.dart';

class MyPantryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyPantryController>(
      () => MyPantryController(),
    );
  }
}
