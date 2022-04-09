part of 'providers.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ListResultState _state;
  ListResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantList> _favorites = [];
  List<RestaurantList> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getBookmarks();
    if (_favorites.isNotEmpty) {
      _state = ListResultState.hasData;
    } else {
      _state = ListResultState.noData;
      _message = 'There is no list of favorite restaurants.';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantList restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ListResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final favoriteRestaurant = await databaseHelper.getFavoriteByID(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ListResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}