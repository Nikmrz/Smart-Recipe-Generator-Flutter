import 'package:flutter/material.dart';
import 'package:smart_recipe_generator_flutter/app/models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        backgroundColor: const Color.fromARGB(213, 255, 119, 77),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recipe Image
            if (recipe.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  recipe.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

            const SizedBox(height: 20),

            // Recipe Name
            Text(
              recipe.name,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange,
              ),
            ),

            const SizedBox(height: 24),

            // Ingredients Card
            if (recipe.cleanedIngredients.isNotEmpty)
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
                      ...recipe.cleanedIngredients.map(
                        (ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text("• $ingredient"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Instructions Card
            if (recipe.instructions.isNotEmpty)
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
    );
  }
}
