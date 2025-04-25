import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/modules/home/controllers/favorite_recipes_controller.dart';
import 'package:smart_recipe_generator_flutter/app/modules/recipe_detail/views/recipe_detail_view.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Instantiate the controller
    final FavoriteRecipesController favoriteRecipesController = Get.put(
      FavoriteRecipesController(),
    );

    // Fetch favorite recipes on initial load
    favoriteRecipesController.fetchFavoriteRecipes();

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes')),
      body: Obx(() {
        // Using Obx to listen to the changes in isLoading and favoriteRecipes
        if (favoriteRecipesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: favoriteRecipesController.favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = favoriteRecipesController.favoriteRecipes[index];
            return ListTile(
              leading: Image.network(
                recipe.imageUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) =>
                        const Icon(Icons.image_not_supported),
              ),
              title: Text(recipe.name),
              subtitle: Text(
                '${recipe.cleanedIngredients.length} ingredients',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              onTap: () => Get.to(() => RecipeDetailView(recipe: recipe)),
            );
          },
        );
      }),
    );
  }
}
