import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;
  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleIsFavorite(String authToken, String userId) async {
    final url =
        'https://shopapp-46a87.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
        throw HttpException('Could not complete request.');
      }
    } catch (error) {
      isFavorite = !isFavorite;
      notifyListeners();
      throw HttpException('Could not complete request.');
    }
  }
}
