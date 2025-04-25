import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/modules/home/controllers/favorite_recipes_controller.dart';
import 'package:smart_recipe_generator_flutter/app/modules/recipe_detail/views/recipe_detail_view.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FavoriteRecipesController favoriteRecipesController = Get.put(
      FavoriteRecipesController(),
    );

    // Fetch recipes when screen is built
    favoriteRecipesController.fetchFavoriteRecipes();

    return Scaffold(
      appBar: AppBar(title: Text('Favorite Recipes'), automaticallyImplyLeading: false),
      body: Obx(() {
        if (favoriteRecipesController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (favoriteRecipesController.favoriteRecipes.isEmpty) {
          return Center(
            child: Text(
              'You don’t have any recipes added to your favorites.',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          );
        }

        return ListView.builder(
          padding: EdgeInsets.all(12),
          itemCount: favoriteRecipesController.favoriteRecipes.length,
          itemBuilder: (context, index) {
            final recipe = favoriteRecipesController.favoriteRecipes[index];
            return GestureDetector(
              onTap: () => Get.to(() => RecipeDetailView(recipe: recipe)),
              child: Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: SizedBox(
                  height: 200, // Fix the entire card height
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            recipe.imageUrl,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported),
                                ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                recipe.name,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Ingredients:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                              SizedBox(height: 4),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Wrap(
                                    spacing: 6,
                                    runSpacing: -4,
                                    children:
                                        recipe.ingredients.map((ingredient) {
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                              0,
                                              8.0,
                                              0,
                                              0,
                                            ),
                                            child: Chip(
                                              label: Text(
                                                ingredient.name,
                                                style: TextStyle(fontSize: 12),
                                              ),
                                              backgroundColor: Colors.green
                                                  .withOpacity(0.1),
                                            ),
                                          );
                                        }).toList(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
