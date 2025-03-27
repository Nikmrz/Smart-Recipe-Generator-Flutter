import 'package:flutter/material.dart';

class Recipe {
  final String id;
  final String name;
  final String imageUrl;
  final int cookTime; // in minutes
  final List<String> tags;

  Recipe({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cookTime,
    required this.tags,
  });
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();

  // Mock data - replace with your actual data from backend
  List<Recipe> recommendedRecipes = [
    Recipe(
      id: '1',
      name: 'Pasta Carbonara',
      imageUrl: 'https://cooking.nytimes.com/recipes/12965-spaghetti-carbonara',
      cookTime: 25,
      tags: ['Italian', 'Dinner'],
    ),
    Recipe(
      id: '2',
      name: 'Chicken Stir Fry',
      imageUrl: 'https://natashaskitchen.com/chicken-stir-fry-recipe/',
      cookTime: 30,
      tags: ['Asian', 'Dinner'],
    ),
    Recipe(
      id: '3',
      name: 'Greek Salad',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 15,
      tags: ['Greek', 'Healthy', 'Lunch'],
    ),
  ];
  
  List<Recipe> recentRecipes = [
    Recipe(
      id: '4',
      name: 'Avocado Toast',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 10,
      tags: ['Breakfast', 'Quick'],
    ),
    Recipe(
      id: '5',
      name: 'Mushroom Risotto',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 45,
      tags: ['Italian', 'Dinner'],
    ),
  ];
  
  List<Recipe> trendingRecipes = [
    Recipe(
      id: '6',
      name: 'Salmon Poke Bowl',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 20,
      tags: ['Japanese', 'Healthy'],
    ),
    Recipe(
      id: '7',
      name: 'Berry Smoothie Bowl',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 10,
      tags: ['Breakfast', 'Healthy'],
    ),
    Recipe(
      id: '8',
      name: 'Vegetable Curry',
      imageUrl: 'https://via.placeholder.com/150',
      cookTime: 35,
      tags: ['Indian', 'Vegetarian'],
    ),
  ];

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
      // Implement search functionality
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Searching for: ${_searchController.text}'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _findRecipesFromPantry() {
    // Implement "What can I make now?" functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Finding recipes from your pantry ingredients...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () {
        // Navigate to recipe detail page
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Opening recipe: ${recipe.name}'),
            duration: Duration(seconds: 2),
          ),
        );
      },
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 4),
                      Text(
                        '${recipe.cookTime} min',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(height: 12),
        Container(
          height: 200,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: recipes.length,
            itemBuilder: (context, index) => _buildRecipeCard(recipes[index]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search bar
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
              
              // Quick ingredient add
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
              
              // "What can I make now?" button
              Padding(
                padding: EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: _findRecipesFromPantry,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.restaurant),
                      SizedBox(width: 8),
                      Text(
                        'What Can I Make Now?',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              
              SizedBox(height: 16),
              
              // Recommendations section
              _buildRecipeSection('Based on Your Past Preferences', recommendedRecipes),
              
              SizedBox(height: 24),
              
              // Recently viewed section
              _buildRecipeSection('Recently Viewed', recentRecipes),
              
              SizedBox(height: 24),
              
              // Trending section
              _buildRecipeSection('Trending Now', trendingRecipes),
              
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