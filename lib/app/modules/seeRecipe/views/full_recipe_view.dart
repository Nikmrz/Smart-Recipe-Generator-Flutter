import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/see_recipe_controller.dart';

class FullRecipeView extends StatelessWidget {
  final RecipeData recipeData;

  const FullRecipeView({super.key, required this.recipeData});

  void addToShoppingList(String item) {
    // Replace with your controller logic
    Get.snackbar("Added", '"$item" added to shopping list',
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    final recipe = recipeData.recipe;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Smart Chef    "),
            Image(
              image: const AssetImage('assets/icons/applogo.png'),
              fit: BoxFit.contain,
              height: 35,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Recipe image
              if (recipe.pictureUrl != null)
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                    recipe.pictureUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: Colors.grey[300],
                        child: const Icon(Icons.restaurant, size: 60),
                      );
                    },
                  ),
                )
              else
                Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: const Icon(Icons.restaurant, size: 60),
                ),
              const SizedBox(height: 16),

              Text(
                recipe.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),

              const Text(
                'Ingredients:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              ...recipe.ingredients.map((ingredient) {
                final isAvailable = recipeData.matchingIngredients.contains(ingredient.name);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        isAvailable ? Icons.check_circle : Icons.remove_circle_outline,
                        size: 18,
                        color: isAvailable ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(ingredient.name)),
                      if (!isAvailable)
                        TextButton.icon(
                          onPressed: () => addToShoppingList(ingredient.name),
                          icon: const Icon(Icons.add_shopping_cart, size: 16),
                          label: const Text("Add"),
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                        ),
                    ],
                  ),
                );
              }).toList(),

              const SizedBox(height: 24),
              const Text(
                'Instructions:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),

              ...recipe.instructions.map((instruction) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('• $instruction'),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
