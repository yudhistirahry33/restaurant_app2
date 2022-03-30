part of 'providers.dart';

enum DetailResultState { Loading, NoData, HasData, Error }

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  final String restaurantID;

  DetailRestaurantProvider({required this.restaurantID, required this.apiService}) {
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
      _state = DetailResultState.Loading;
      notifyListeners();
      final detailRestaurant = await apiService.detailRestaurant(id);
      if (detailRestaurant.error) {
        _state = DetailResultState.NoData;
        notifyListeners();
      } else {
        _state = DetailResultState.HasData;
        notifyListeners();
        return _detailRestaurantResult = detailRestaurant;
      }
    } catch (e) {
      _state = DetailResultState.Error;
      notifyListeners();
      return _message = 'Sorry, please connect your phone to the internet.';
    }
  }
}