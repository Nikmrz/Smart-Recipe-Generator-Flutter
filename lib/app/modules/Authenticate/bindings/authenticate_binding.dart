import 'package:get/get.dart';

import '../controllers/authenticate_controller.dart';

class AuthenticateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthenticateController>(
      () => AuthenticateController(),
    );
  }
}
