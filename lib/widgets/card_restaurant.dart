import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/models.dart';
import 'package:restaurant_app/provider/providers.dart';
import 'package:restaurant_app/page/information_page.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantList restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorite(restaurant.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return InkWell(
              onTap: () => Navigation.intentWithData(InformationPage.routeName, restaurant.id),
              child: Card(
                margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Hero(
                          tag: restaurant.pictureId,
                          child: Center(
                            child: Image.network(
                              ApiService.baseUrlImage + restaurant.pictureId,
                              fit: BoxFit.cover,
                              errorBuilder: (BuildContext context, Object exception,
                                  StackTrace? stackTrace) {
                                return const Text('Can\'t load the image.');
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  restaurant.name,
                                  style: heading3,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.brown,
                                    ),
                                    Text(restaurant.city, style: subText2),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                    ),
                                    Text(restaurant.rating.toString(), style: subText2),
                                  ],
                                ),
                              ],
                            ),
                            isFavorite
                                ? IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.red,
                              onPressed: () => provider.removeFavorite(restaurant.id),
                            )
                                : IconButton(
                              icon: Icon(Icons.favorite),
                              color: Colors.grey,
                              onPressed: () => provider.addFavorite(restaurant),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
