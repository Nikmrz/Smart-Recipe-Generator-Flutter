import 'package:smart_recipe_generator_flutter/app/models/ingredient.dart';

class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> instructions;
  final List<String> cleanedIngredients;
  final List<Ingredient> ingredients;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.instructions,
    required this.cleanedIngredients,
    required this.ingredients,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'].toString(),
      name: json['title'],
      imageUrl: json['picture_url'],
      instructions: List<String>.from(json['instructions'] ?? []),
      cleanedIngredients: List<String>.from(json['cleaned_ingredients'] ?? []),
      ingredients:
          (json['ingredients'] as List)
              .map((e) => Ingredient.fromJson(e))
              .toList(),
    );
  }
}
