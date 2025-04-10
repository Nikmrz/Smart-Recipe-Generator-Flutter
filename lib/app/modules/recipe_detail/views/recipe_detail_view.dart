import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/models/recipe.dart';

class RecipeDetailView extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailView({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_border),
            onPressed: () {
              Get.snackbar("Favorite", "Added to favorites!");
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                recipe.imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Feedback Section
            const Text("Rate this recipe", style: TextStyle(fontSize: 16)),
            Row(
              children: List.generate(
                5,
                (index) => const Icon(Icons.star_border, color: Colors.amber),
              ),
            ),
            const SizedBox(height: 20),

            // Ingredients Section
            const Text("Ingredients", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              // children: recipe.ingredients.map((ingredient) {
              //   bool inPantry = ingredient.contains('rice') || ingredient.toLowerCase().contains('chicken');
              //   return Chip(
              //     label: Text(ingredient),
              //     backgroundColor: inPantry ? Colors.green[100] : Colors.red[100],
              //     avatar: Icon(
              //       inPantry ? Icons.check_circle : Icons.cancel,
              //       color: inPantry ? Colors.green : Colors.red,
              //     ),
              //   );
              // }).toList(),
            ),
            const SizedBox(height: 20),

            // Instructions Section
            const Text("Instructions", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // children: recipe.steps.asMap().entries.map((entry) {
              //   int stepNumber = entry.key + 1;
              //   String step = entry.value;
              //   return Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4),
              //     child: Text("$stepNumber. $step", style: const TextStyle(fontSize: 14)),
              //   );
              // }).toList(),
            ),

            const SizedBox(height: 20),
            // Text("Time: ${recipe.cookTime} minutes"),

            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Get.snackbar("Let's Cook", "You're ready to start cooking!");
              },
              child: const Text("Start Making Now"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),

            const SizedBox(height: 32),
            const Text("You May Also Like", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              height: 100,
              alignment: Alignment.center,
              child: const Text("Coming soon...", style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }
}
