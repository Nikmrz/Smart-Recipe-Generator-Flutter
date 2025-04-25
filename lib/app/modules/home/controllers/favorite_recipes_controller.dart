import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/models/recipe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get_storage/get_storage.dart';

class FavoriteRecipesController extends GetxController {
  var favoriteRecipes =
      <Recipe>[].obs; // Observable list to hold favorite recipes
  var isLoading = true.obs; // Observable to hold the loading state

  // Fetch favorite recipes
  Future<void> fetchFavoriteRecipes() async {
    final box = GetStorage();
    final token = box.read('auth_token');

    if (token == null) {
      print('No token found');
      return;
    }

    isLoading(true);

    final response = await http.get(
      Uri.parse('http://localhost:4000/favorites'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      favoriteRecipes.value =
          data.map((item) => Recipe.fromJson(item)).toList();
    } else {
      print('Failed to load favorite recipes');
    }

    isLoading(false);
  }
}
