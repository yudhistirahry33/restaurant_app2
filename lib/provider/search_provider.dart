part of 'providers.dart';

enum SearchResultState { loading, noData, hasData, error }

class SearchProvider extends ChangeNotifier {
  final ApiService apiService;
  // final String query;

  SearchProvider({required this.apiService}) {
    fetchSearchRestaurant(query);
  }

  SearchRestaurantResult? _searchResult;
  SearchResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;

  SearchRestaurantResult? get result => _searchResult;

  SearchResultState? get state => _state;

  String get query => _query;

  Future<dynamic> fetchSearchRestaurant(String query) async {
    try {
      _state = SearchResultState.loading;
      _query = query;
      final search = await apiService.searchRestaurant(query);
      if (search.restaurants.isEmpty) {
        _state = SearchResultState.noData;
        notifyListeners();
        return _message = 'Can\'t find restaurant.';
      } else {
        _state = SearchResultState.hasData;
        notifyListeners();
        return _searchResult = search;
      }
    } catch (e) {
      _state = SearchResultState.error;
      notifyListeners();
      return _message = 'Sorry, please connect your phone to the internet.';
    }
  }
}
