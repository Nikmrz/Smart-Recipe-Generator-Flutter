class Ingredient {
  final String name;
  final String? category;

  Ingredient({required this.name, this.category});

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(name: json['name'], category: json['category']);
  }
}
