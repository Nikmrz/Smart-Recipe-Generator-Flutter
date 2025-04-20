import 'package:get/get.dart';

import '../modules/Authenticate/bindings/authenticate_binding.dart';
import '../modules/Authenticate/views/authenticate_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/myPantry/bindings/my_pantry_binding.dart';
import '../modules/myPantry/views/my_pantry_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/introduction_animation_screen.dart';
import '../modules/seeRecipe/bindings/see_recipe_binding.dart';
import '../modules/seeRecipe/views/see_recipe_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARDING;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const IntroductionAnimationScreen(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATE,
      page: () => const AuthenticateView(),
      binding: AuthenticateBinding(),
    ),
    // GetPage(
    //   name: _Paths.RECIPE_DETAIL,
    //   // page: () => RecipeDetailView(recipe: Get.arguments),
    //   binding: RecipeDetailBinding(),
    // ),
    GetPage(
      name: _Paths.MY_PANTRY,
      page: () => const MyPantryView(),
      binding: MyPantryBinding(),
    ),
    GetPage(
      name: _Paths.SEE_RECIPE,
      page: () => const SeeRecipeView(),
      binding: SeeRecipeBinding(),
    ),
  ];
}
