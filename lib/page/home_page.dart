import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/page/favorite_page.dart';
import 'package:restaurant_app/provider/providers.dart';
import 'package:restaurant_app/page/search_page.dart';
import 'package:restaurant_app/page/setting_page.dart';
import 'package:restaurant_app/utils/list_result_state.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/card_restaurant.dart';

import 'information_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  int _bottomNavIndex = 0;

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const SearchPage(),
    const FavoritePage(),
    const SettingPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.restaurant),
      label: 'Restaurants',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: 'Search',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Favorites',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: 'Settings',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        InformationPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }
}

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.asset(
                  'images/resto.jpg',
                  fit: BoxFit.cover,
                ),
                title: Text('Best Restaurant in Indonesia', style: heading1),
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
            ),
          ];
        },
        body: Consumer<RestaurantListProvider>(
          builder: (context, state, _) {
            if (state.state == ListResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ListResultState.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.result.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result.restaurants[index];
                  return CardRestaurant(
                    restaurant: restaurant,
                  );
                },
              );
            } else if (state.state == ListResultState.noData) {
              return Center(child: Text(state.message));
            } else if (state.state == ListResultState.error) {
              return Center(child: Text(state.message));
            } else {
              return const Center(
                  child: Text(
                      'Sorry, please connect your phone to the internet.'));
            }
          },
        ),
      ),
    );
  }
}
