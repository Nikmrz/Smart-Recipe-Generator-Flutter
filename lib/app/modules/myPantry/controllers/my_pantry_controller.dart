import 'package:get/get.dart';

class MyPantryController extends GetxController {
  var myPantryItems = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPantryItems(); // Simulate backend fetch
  }

  var favoriteItems = <String>[].obs;

  void toggleFavorite(String item) {
    if (favoriteItems.contains(item)) {
      favoriteItems.remove(item);
    } else {
      favoriteItems.add(item);
    }
  }

  void fetchPantryItems() {
    // Replace with real backend fetch
    myPantryItems.assignAll(['Tomato', 'Onion', 'Garlic']);
  }
  void addToShoppingList(String item) {
  // TODO: send to backend or update list
    print('Added "$item" to shopping list');
  // You can add logic to update a local shoppingList RxList too if needed
  }

  void removeItem(String item) {
    myPantryItems.remove(item);
    // TODO: Call backend to delete
  }
}
