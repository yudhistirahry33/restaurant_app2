part of 'providers.dart';

enum ListResultState { loading, noData, hasData, error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  late RestaurantListResult _restaurantResult;
  late ListResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResult get result => _restaurantResult;

  ListResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ListResultState.loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ListResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ListResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ListResultState.error;
      notifyListeners();
      return _message = 'Sorry, please connect your phone to the internet.';
    }
  }
}