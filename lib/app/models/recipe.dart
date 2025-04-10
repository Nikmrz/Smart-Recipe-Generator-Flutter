class Recipe {
  final String name;
  final String imageUrl;
  final int cookTime;
  final List<String> ingredients;
  final List<String> steps;

  Recipe({
    required this.name,
    required this.imageUrl,
    required this.cookTime,
    required this.ingredients,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['title'],
      imageUrl: json['picture_url'],
      cookTime: json['cook_time'] ?? 0,  // Default value in case `cook_time` is missing
      ingredients: List<String>.from(json['ingredients']),
      steps: List<String>.from(json['instructions']),
    );
  }
}
