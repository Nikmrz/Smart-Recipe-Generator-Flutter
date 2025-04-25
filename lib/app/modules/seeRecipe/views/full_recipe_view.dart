import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/modules/recipe_detail/views/favorite_icon_button.dart';
import '../controllers/see_recipe_controller.dart';

class FullRecipeView extends StatelessWidget {
  final RecipeData recipeData;

  const FullRecipeView({super.key, required this.recipeData});

  void addToShoppingList(String item) {
    Get.snackbar(
      "Added",
      '"$item" added to shopping list',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.9),
      colorText: Colors.white,
      icon: const Icon(Icons.check, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recipe = recipeData.recipe;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 2,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Smart Chef", style: TextStyle(color: Colors.black)),
            const SizedBox(width: 8),
            Image.asset('assets/icons/applogo.png', height: 35),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// 🔹 **Recipe Image**
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  recipe.imageUrl ?? '',
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 220,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.grey[300],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.restaurant,
                          size: 60,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 **Recipe Name & Favorite Icon**
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      recipe.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepOrange,
                      ),
                    ),
                  ),
                  FavoriteIconButton(
                    recipeId: recipe.id,
                    recipeName: recipe.name,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// 🔹 **Ingredients Card**
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Section Title
                      Row(
                        children: const [
                          Icon(Icons.restaurant_menu, color: Colors.deepOrange),
                          SizedBox(width: 8),
                          Text(
                            "Ingredients",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      /// Ingredients List
                      ...recipe.ingredients.map((ingredient) {
                        final isAvailable = recipeData.matchingIngredients
                            .contains(ingredient.name);
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(
                                isAvailable
                                    ? Icons.check_circle
                                    : Icons.remove_circle_outline,
                                size: 18,
                                color:
                                    isAvailable ? Colors.green : Colors.orange,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text(ingredient.name)),

                              /// Add to Shopping List Button
                              if (!isAvailable)
                                TextButton.icon(
                                  onPressed:
                                      () => addToShoppingList(ingredient.name),
                                  icon: const Icon(
                                    Icons.add_shopping_cart,
                                    size: 16,
                                  ),
                                  label: const Text("Add"),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.teal,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              /// 🔹 **Instructions Card**
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Section Title
                      Row(
                        children: const [
                          Icon(Icons.list_alt, color: Colors.deepOrange),
                          SizedBox(width: 8),
                          Text(
                            "Instructions",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      /// Instructions List
                      ...List.generate(
                        recipe.instructions.length,
                        (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${index + 1}. ",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Expanded(child: Text(recipe.instructions[index])),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
