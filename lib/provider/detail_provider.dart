part of 'providers.dart';

enum DetailResultState { loading, noData, hasData, error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantID;

  DetailRestaurantProvider(
      {required this.restaurantID, required this.apiService}) {
    _fetchDetailRestaurant(restaurantID);
  }

  late RestaurantDetailResult _detailRestaurantResult;
  late DetailResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get detailRestaurant => _detailRestaurantResult;

  DetailResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant(String id) async {
    try {
      _state = DetailResultState.loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = DetailResultState.hasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = DetailResultState.error;
      notifyListeners();
      return _message = 'Sorry, please connect your phone to the internet.';
    }
  }
}
