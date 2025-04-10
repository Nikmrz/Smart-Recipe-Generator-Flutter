import 'package:flutter/material.dart';
import 'package:smart_recipe_generator_flutter/app/models/recipe.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/modules/recipe_detail/views/recipe_detail_view.dart';

class SeeMoreRecipesScreen extends StatelessWidget {
  final String title;
  final List<Recipe> recipes;

  const SeeMoreRecipesScreen({required this.title, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
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
      ),
    );
  }
}
