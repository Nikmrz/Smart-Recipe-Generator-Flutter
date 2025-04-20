import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/modules/seeRecipe/views/full_recipe_view.dart';
import 'package:smart_recipe_generator_flutter/app/modules/seeRecipe/views/see_recipe_view.dart';

class SeeRecipeController extends GetxController {
  final isLoading = true.obs;
  final recipes = <RecipeData>[].obs;
  final totalRecipes = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRecipes();
  }

  void fetchRecipes() async {
    isLoading.value = true;
    
    try {
      // This would be your actual API call
      // Replace with actual API integration
      await Future.delayed(const Duration(seconds: 1));
      
      // Parse sample response
      final sampleResponse = {
        "total_recipes": 5196,
        "recipes": [
          {
            "recipe": {
              "id": 11101,
              "title": "Red Onion, Sour Cream, and Caviar Quesadillas",
              "ingredients": [
                {
                  "id": 21,
                  "name": "onions",
                  "ingredient_category_id": null,
                  "created_at": "2025-04-08T16:05:38.534Z",
                  "updated_at": "2025-04-08T16:05:38.534Z"
                },
                {
                  "id": 129,
                  "name": "sour cream",
                  "ingredient_category_id": null,
                  "created_at": "2025-04-08T16:05:38.720Z",
                  "updated_at": "2025-04-08T16:05:38.720Z"
                }
              ],
              "instructions": [
                "Fold tortillas in half and cut each quesadilla into 3 wedges. Garnish with:",
                "2 tablespoons sour cream",
                "2 tablespoons caviar",
                "Red onion slivers",
                "Small dill sprigs",
                "6 thin lemon slices"
              ],
              "image_name": "red-onion-sour-cream-and-caviar-quesadillas-233906",
              "cleaned_ingredients": [
                "2 6- to 8-inch flour tortillas",
                "4 tablespoons sour cream",
                "2 tablespoons chopped red onion"
              ],
              "created_at": "2025-03-26T11:22:25.023Z",
              "updated_at": "2025-03-26T11:22:25.023Z"
            },
            "pantry_ingredients_used": 1,
            "missing_ingredients": ["sour cream"],
            "matching_ingredients": ["onions"],
            "total_ingredients": 2
          },
          {
            "recipe": {
              "id": 13067,
              "title": "Passion-Fruit Mimosa",
              "ingredients": [
                {
                  "name": "ham",
                  "category": null
                }
              ],
              "instructions": [
                "Divide champagne between 2 glasses and top off each drink with nectar or juice (3 to 4 tablespoons)."
              ],
              "cleaned_ingredients": [
                "1 cup chilled champagne",
                "1/2 cup chilled passionfruit nectar or juice"
              ],
              "picture_url": "http://localhost:4000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MTMwMzcsInB1ciI6ImJsb2JfaWQifX0=--d0fa8e88d7605b6d5044ca9326a749246585e2fa/passion-fruit-mimosa-200798.jpg"
            },
            "pantry_ingredients_used": 1,
            "missing_ingredients": [],
            "matching_ingredients": ["ham"],
            "total_ingredients": 1
          }
        ]
      };

      totalRecipes.value = sampleResponse["total_recipes"] as int;
      
      final recipesList = (sampleResponse["recipes"] as List)
        .map((recipeData) => RecipeData.fromJson(recipeData))
        .toList();
        
      recipes.assignAll(recipesList);
    } catch (e) {
      print('Error fetching recipes: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  void showFullRecipe(RecipeData recipeData) {
    Get.to(() => FullRecipeView(recipeData: recipeData));
  }
}

class RecipeData {
  final Recipe recipe;
  final int pantryIngredientsUsed;
  final List<String> missingIngredients;
  final List<String> matchingIngredients;
  final int totalIngredients;
  
  RecipeData({
    required this.recipe,
    required this.pantryIngredientsUsed,
    required this.missingIngredients,
    required this.matchingIngredients,
    required this.totalIngredients,
  });
  
  factory RecipeData.fromJson(Map<String, dynamic> json) {
    return RecipeData(
      recipe: Recipe.fromJson(json["recipe"]),
      pantryIngredientsUsed: json["pantry_ingredients_used"],
      missingIngredients: List<String>.from(json["missing_ingredients"] ?? []),
      matchingIngredients: List<String>.from(json["matching_ingredients"] ?? []),
      totalIngredients: json["total_ingredients"],
    );
  }
}

class Recipe {
  final int id;
  final String title;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  final String? imageName;
  final String? pictureUrl;
  final List<String> cleanedIngredients;
  
  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
    this.imageName,
    this.pictureUrl,
    required this.cleanedIngredients,
  });
  
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json["id"],
      title: json["title"],
      ingredients: json["ingredients"] == null 
          ? [] 
          : List<Ingredient>.from(
              (json["ingredients"] as List).map((x) => Ingredient.fromJson(x))
            ),
      instructions: List<String>.from(json["instructions"] ?? []),
      imageName: json["image_name"],
      pictureUrl: json["picture_url"],
      cleanedIngredients: List<String>.from(json["cleaned_ingredients"] ?? []),
    );
  }
}

class Ingredient {
  final String name;
  final String? category;
  
  Ingredient({
    required this.name,
    this.category,
  });
  
  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      name: json["name"],
      category: json["category"],
    );
  }
}