import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
