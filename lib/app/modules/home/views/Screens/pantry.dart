import 'package:flutter/material.dart';

class Pantry extends StatefulWidget {
  @override
  _PantryState createState() => _PantryState();
}

class _PantryState extends State<Pantry> {
  // Categories and their respective choices
  final Map<String, List<String>> categories = {
    "Pantry Essentials": ["Rice", "Pasta", "Flour", "Sugar", "Salt", "Oil"],
    "Vegetables and Greens": ["Spinach", "Lettuce", "Carrot", "Broccoli", "Tomato"],
    "Mushrooms": ["Button Mushroom", "Shiitake", "Portobello", "Oyster Mushroom"],
  };

  // Stores selected choices
  List<String> selectedItems = [];

  // Toggles selection for an item
  void toggleSelection(String item) {
    setState(() {
      if (selectedItems.contains(item)) {
        selectedItems.remove(item); // Deselect if already selected
      } else {
        selectedItems.add(item); // Add to selected list
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pantry")),
      body: Column(
        children: [
          // Display selected items at the top
          if (selectedItems.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Wrap(
                spacing: 8,
                children: selectedItems.map((item) {
                  return Chip(
                    label: Text(item),
                    backgroundColor: Colors.lightBlueAccent,
                    deleteIcon: Icon(Icons.close, size: 18),
                    onDeleted: () {
                      toggleSelection(item); // Remove when clicked
                    },
                  );
                }).toList(),
              ),
            ),
          Expanded(
            child: ListView(
              children: categories.entries.map((entry) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Title
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        entry.key,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    // Choices under the category
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: entry.value.map((choice) {
                        return ChoiceChip(
                          selected: selectedItems.contains(choice),
                          onSelected: (selected) {
                            toggleSelection(choice);
                          },
                          label: Text(choice),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 10), // Add spacing between categories
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
