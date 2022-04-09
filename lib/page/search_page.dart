import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/provider/providers.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

import '../data/api/api_service.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  String queries = '';

  Widget _searchRestaurant(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, state, _) {
      if (state.state == SearchResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state.state == SearchResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result!.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result!.restaurants[index];
            return CardRestaurant(
              restaurant: restaurant,
            );
          },
        );
      } else if (state.state == SearchResultState.noData) {
        return Center(child: Text(state.message));
      } else if (state.state == SearchResultState.error) {
        return Center(child: Text(state.message));
      } else {
        return const Center(
            child: Text('Sorry, please connect your phone to the internet.'));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Restaurant'),
      ),
      body: ChangeNotifierProvider<SearchProvider>(
        create: (_) => SearchProvider(
          apiService: ApiService(),
        ),
        child: Consumer<SearchProvider>(builder: (context, state, _) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      queries = value;
                    });
                    state.fetchSearchRestaurant(value);
                  },
                  autofocus: true,
                  cursorColor: primaryColor,
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Find Restaurant...',
                    hintStyle: subText2,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  child: queries.isEmpty
                      ? const Center(child: Text(''))
                      : _searchRestaurant(context),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
