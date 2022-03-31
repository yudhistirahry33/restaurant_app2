import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/models.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const String baseUrlImage = '${_baseUrl}images/medium/';

  Future<RestaurantListResult> listRestaurant() async {
    final response = await http.get(Uri.parse(
        "${_baseUrl}list"));
    if (response.statusCode == 200) {
      return RestaurantListResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant list');
    }
  }

  Future<RestaurantDetailResult> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse('${_baseUrl}detail/$id'));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load Detail Restaurant');
    }
  }

  Future<SearchRestaurantResult> searchRestaurant(String query) async {
    final response = await http.get(Uri.parse('${_baseUrl}search?q=$query'));

    if(response.statusCode == 200) {
      return SearchRestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to Search Restaurant');
    }
  }
}