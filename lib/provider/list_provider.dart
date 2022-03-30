part of 'providers.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchListRestaurant();
  }

  late RestaurantListResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantListResult get result => _restaurantResult;

  ResultState get state => _state;

  Future<dynamic> _fetchListRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.listRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Sorry, please connect your phone to the internet.';
    }
  }
}