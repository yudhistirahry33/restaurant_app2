import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/models.dart';
import 'package:restaurant_app/ui/information_page.dart';

class CardSearch extends StatelessWidget {
  final RestaurantList restaurant;

  const CardSearch({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, InformationPage.routeName,
            arguments: restaurant.id);
      },
      child: Card(
        margin: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
          ),
        ),
      ),
    );
  }
}
