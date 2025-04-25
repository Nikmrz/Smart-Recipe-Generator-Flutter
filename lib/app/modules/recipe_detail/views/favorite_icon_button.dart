import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smart_recipe_generator_flutter/app/modules/home/controllers/favorite_recipes_controller.dart';

class FavoriteIconButton extends StatefulWidget {
  final String recipeId;
  final String recipeName;

  const FavoriteIconButton({
    Key? key,
    required this.recipeId,
    required this.recipeName,
  }) : super(key: key);

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  bool isFavorite = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchFavoriteStatus(); // Fetch on load
  }

  Future<void> fetchFavoriteStatus() async {
    String? storedToken = GetStorage().read('auth_token');
    final url = Uri.parse("http://localhost:4000/favorites");
    final headers = {"Authorization": "Bearer $storedToken"};

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final List<dynamic> favorites = jsonDecode(response.body);

        final isFav = favorites.any(
          (recipe) => recipe["id"].toString() == widget.recipeId,
        );
        setState(() => isFavorite = isFav);
      } else {
        debugPrint("Failed to fetch favorites: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error fetching favorite status: $e");
    }
  }


  Future<void> toggleFavorite() async {
    setState(() => isLoading = true);

    String? storedToken = GetStorage().read('auth_token');

    final url = Uri.parse("http://localhost:4000/favorites");
    final headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer $storedToken",
    };
    final body = jsonEncode({"id": widget.recipeId});

    try {
      final response =
          isFavorite
              ? await http.delete(url, headers: headers, body: body)
              : await http.post(url, headers: headers, body: body);

      final data = jsonDecode(response.body);
      final success = data["success"] ?? false;

      if (success) {
        Get.find<FavoriteRecipesController>().fetchFavoriteRecipes();

        // Toggle the favorite state
        setState(() => isFavorite = !isFavorite);

        // Show success snackbar with conditional color
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? 'Success'),
            backgroundColor: isFavorite ? Colors.green : Colors.red,
          ),
        );
      } else {
        // Show failure snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data["message"] ?? 'Failed'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Error: $e")));
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(strokeWidth: 2),
        )
        : IconButton(
          icon: Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: Colors.red,
          ),
          onPressed: toggleFavorite,
        );
  }
}
