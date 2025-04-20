import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_recipe_generator_flutter/app/routes/app_pages.dart';

class Pantry extends StatefulWidget {
  @override
  _PantryViewState createState() => _PantryViewState();
}

class _PantryViewState extends State<Pantry> {
  List<String> ingredients = [];
  List<List<String>> groupedIngredients = [];
  List<bool> isExpanded = [];

  List<String> selectedItems = [];
  List<String> myPantryItems = [];

  @override 
  void initState() {
    super.initState();
    fetchIngredients();
  }

  Future<void> fetchIngredients() async {
    final url = Uri.parse('http://localhost:4000/ingredients'); // no limit
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        ingredients = data.map((item) => item.toString()).toList();
        groupedIngredients = _groupIngredients(ingredients, 20);
        isExpanded = List.generate(groupedIngredients.length, (_) => false);
      });
    } else {
      throw Exception('Failed to fetch ingredients');
    }
  }

  List<List<String>> _groupIngredients(List<String> list, int groupSize) {
    List<List<String>> grouped = [];
    for (int i = 0; i < list.length; i += groupSize) {
      grouped.add(list.sublist(i, i + groupSize > list.length ? list.length : i + groupSize));
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

  void confirmPantryAddition() {
    setState(() {
      myPantryItems.addAll(
        selectedItems.where((item) => !myPantryItems.contains(item)),
      );
      selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantry")),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 70), // for fixed bottom bar
            child: groupedIngredients.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: groupedIngredients.length,
                    itemBuilder: (context, index) {
                      final category = 'Category ${index + 1}';
                      final ingredientsInCategory = groupedIngredients[index];
                      final isSectionExpanded = isExpanded[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category,
                                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: Icon(isSectionExpanded
                                          ? Icons.expand_less
                                          : Icons.expand_more),
                                      onPressed: () {
                                        setState(() {
                                          isExpanded[index] = !isExpanded[index];
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                AnimatedCrossFade(
                                  duration: Duration(milliseconds: 300),
                                  crossFadeState: isSectionExpanded
                                      ? CrossFadeState.showFirst
                                      : CrossFadeState.showSecond,
                                  firstChild: Wrap(
                                    spacing: 8,
                                    runSpacing: 10,
                                    children: ingredientsInCategory.map((ingredient) {
                                      return ChoiceChip(
                                        label: Text(ingredient),
                                        selected: selectedItems.contains(ingredient),
                                        onSelected: (_) => toggleSelection(ingredient),
                                      );
                                    }).toList(),
                                  ),
                                  secondChild: Wrap(
                                    spacing: 8,
                                    runSpacing: 10,
                                    children: ingredientsInCategory
                                        .take(8)
                                        .map((ingredient) {
                                      return ChoiceChip(
                                        label: Text(ingredient),
                                        selected: selectedItems.contains(ingredient),
                                        onSelected: (_) => toggleSelection(ingredient),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),

          // Floating "Add to Pantry" button
          if (selectedItems.isNotEmpty)
            Positioned(
              bottom: 80, // just above bottom bar
              left: 0,
              right: 0,
              child: Center(
                child: ElevatedButton(
                  onPressed: confirmPantryAddition,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text("Add to Pantry"),
                ),
              ),
            ),

          // Fixed Bottom Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // My Pantry
                  ElevatedButton.icon(
                    onPressed: () {
                    Get.toNamed(Routes.MY_PANTRY);// Navigate to My Pantry view
                    },
                    icon: Icon(Icons.kitchen),
                    label: Text("My Pantry (${myPantryItems.length})"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),

                  // See Recipe
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed(Routes.SEE_RECIPE); // adjust as needed
                    },
                    child: Text("See Recipe"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
