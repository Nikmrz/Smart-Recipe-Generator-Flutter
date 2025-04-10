import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Pantry extends StatefulWidget {
  @override
  _PantryViewState createState() => _PantryViewState();
}

class _PantryViewState extends State<Pantry> {
  List<String> ingredients = [];
  List<String> selectedItems = [];
  List<List<String>> groupedIngredients = [];

  @override
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    final url = Uri.parse(
      'http://localhost:4000/ingredients?limit=100&offset=100',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        ingredients = data.map((item) => item.toString()).toList();
        // Group the ingredients into categories (30/40 ingredients per category)
        groupedIngredients = _groupIngredients(ingredients, 40);
      });
    } else {
      throw Exception('Failed to fetch ingredients');
    }
  }

  List<List<String>> _groupIngredients(
    List<String> ingredients,
    int groupSize,
  ) {
    List<List<String>> grouped = [];
    for (int i = 0; i < ingredients.length; i += groupSize) {
      grouped.add(
        ingredients.sublist(
          i,
          i + groupSize > ingredients.length
              ? ingredients.length
              : i + groupSize,
        ),
      );
    }
    return grouped;
  }

  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item);
      } else {
        selectedItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantry")),
      body:
          groupedIngredients.isEmpty
              ? Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  // Display selected items as Chips
                  if (selectedItems.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Wrap(
                        spacing: 8,
                        children:
                            selectedItems.map((item) {
                              return Chip(
                                label: Text(item),
                                backgroundColor: Colors.lightBlueAccent,
                                deleteIcon: Icon(Icons.close, size: 18),
                                onDeleted: () => toggleSelection(item),
                              );
                            }).toList(),
                      ),
                    ),
                  // List of grouped ingredients
                  Expanded(
                    child: ListView.builder(
                      itemCount: groupedIngredients.length,
                      itemBuilder: (context, index) {
                        final category = 'Category ${index + 1}';
                        final ingredientsInCategory = groupedIngredients[index];

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Category Title
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 10,
                              ),
                              child: Text(
                                category,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            // List of ingredients in this category
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children:
                                  ingredientsInCategory.map((ingredient) {
                                    return ChoiceChip(
                                      selected: selectedItems.contains(
                                        ingredient,
                                      ),
                                      onSelected: (selected) {
                                        toggleSelection(ingredient);
                                      },
                                      label: Text(ingredient),
                                    );
                                  }).toList(),
                            ),
                            SizedBox(
                              height: 10,
                            ), // Add spacing between categories
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
