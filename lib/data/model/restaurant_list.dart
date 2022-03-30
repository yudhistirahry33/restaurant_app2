part of 'models.dart';

class RestaurantListResult {
  RestaurantListResult({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  bool error;
  String message;
  int count;
  List<RestaurantList> restaurants;

  factory RestaurantListResult.fromJson(Map<String, dynamic> json) => RestaurantListResult(
    error: json["error"],
    message: json["message"],
    count: json["count"],
    restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
  );
}

class RestaurantList {
  RestaurantList({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );
}
