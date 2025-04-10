import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_recipe_generator_flutter/app/models/recipe.dart';
import 'package:smart_recipe_generator_flutter/app/modules/home/views/Screens/SeeMoreRecipeScreen.dart';
import 'package:smart_recipe_generator_flutter/app/modules/recipe_detail/views/recipe_detail_view.dart';
import 'package:http/http.dart' as http;

// Dummy Login Check
bool isLoggedIn = true; // Toggle this to test UI

List<Recipe> allRecipes = [];
bool isLoading = false;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();

  // Method to fetch recipe data
  Future<void> _fetchRecipes() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://localhost:4000/recipes?limit=10&offset=10'));

    if (response.statusCode == 200) {
      // Parse the JSON response into a list of recipes
      List<dynamic> recipeData = json.decode(response.body);

      setState(() {
        allRecipes = recipeData.map((data) => Recipe.fromJson(data)).toList();
        isLoading = false;
      });
    } else {
      // Handle error
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to load recipes')));
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchRecipes(); // Call the fetch method when the page loads
  }

  void _addIngredient() {
    if (_ingredientController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added ${_ingredientController.text} to pantry'),
          duration: Duration(seconds: 2),
        ),
      );
      _ingredientController.clear();
    }
  }

  void _searchRecipes() {
    if (_searchController.text.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching for: ${_searchController.text}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _findRecipesFromPantry() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Finding recipes from your pantry ingredients...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () => Get.to(() => RecipeDetailView(recipe: recipe)),
      child: Container(
        width: 160,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                recipe.imageUrl,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(
                        '${recipe.cookTime} min',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecipeSection(String title, List<Recipe> recipes) {
    const int maxToShow = 6;

    if (recipes.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (recipes.length > maxToShow)
                TextButton(
                  onPressed: () {
                    Get.to(() => SeeMoreRecipesScreen(title: title, recipes: recipes));
                  },
                  child: Text("See More"),
                )
            ],
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length > maxToShow ? maxToShow : recipes.length,
            itemBuilder: (context, index) => _buildRecipeCard(recipes[index]),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? Center(child: CircularProgressIndicator()) // Show loading indicator
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search recipes...',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () => _searchController.clear(),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                          contentPadding: EdgeInsets.symmetric(vertical: 0),
                        ),
                        onSubmitted: (_) => _searchRecipes(),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _ingredientController,
                              decoration: InputDecoration(
                                hintText: 'Add ingredient to pantry',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addIngredient,
                            child: Icon(Icons.add),
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: ElevatedButton(
                        onPressed: _findRecipesFromPantry,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.restaurant),
                            SizedBox(width: 8),
                            Text('What Can I Make Now?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),

                    if (isLoggedIn) ...[
                      _buildRecipeSection('Based on Your Past Preferences', allRecipes), // You can replace this section as needed
                    ],
                    _buildRecipeSection('Discover Recipes', allRecipes),
                    SizedBox(height: 24),
                  ],
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _ingredientController.dispose();
    super.dispose();
  }
}
