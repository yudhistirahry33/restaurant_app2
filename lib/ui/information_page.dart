import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:like_button/like_button.dart';
import 'package:restaurant_app/provider/providers.dart';

class InformationPage extends StatefulWidget {
  static const routeName = '/restaurant_info';

  final String id;

  const InformationPage({required this.id});

  @override
  State<InformationPage> createState() => _InformationPageState();
}

class _InformationPageState extends State<InformationPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(), restaurantID: widget.id),
      child: Scaffold(
        body: Consumer<DetailRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == DetailResultState.Loading) {
              return Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.HasData) {
              final restaurant = state.detailRestaurant;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: restaurant.restaurant.pictureId,
                      child: Image.network(
                        ApiService.baseUrlImage + restaurant.restaurant.pictureId,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('Can\'t load the image.');
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.restaurant.name,
                                style: heading1,
                              ),
                              const LikeButton(),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                color: Colors.brown,
                              ),
                              Text(restaurant.restaurant.city, style: subText2),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Text(restaurant.restaurant.rating.toString(), style: subText2),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text('Description', style: heading2),
                          Text(restaurant.restaurant.description,
                              style: subText2, textAlign: TextAlign.justify),
                          const SizedBox(height: 16),
                          Text('Menus', style: heading2),
                          const SizedBox(height: 8),
                          Text('Foods:', style: subText1),
                          SizedBox(
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: restaurant.restaurant.menus.foods.map((food) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () {
                                      const snackBar = SnackBar(
                                        content: Text('Added to Cart'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: Image.asset('images/foods.jpg',
                                                height: 150)),
                                        Text(food.name, style: subText2),
                                        Text('Rp25.000', style: subText2),
                                        const LikeButtonWidget(),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text('Drinks:', style: subText1),
                          SizedBox(
                            height: 220,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: restaurant.restaurant.menus.drinks.map((drink) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: InkWell(
                                    onTap: () {
                                      const snackBar = SnackBar(
                                        content: Text('Added to Cart'),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    },
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: Image.asset('images/drinks.jpg',
                                                height: 150)),
                                        Text(drink.name, style: subText2),
                                        Text('Rp10.000', style: subText2),
                                        const LikeButtonWidget(),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else if (state.state == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.Error) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text(''));
            }
          }
        ),
        floatingActionButton: SizedBox(
          height: 40.0,
          width: 40.0,
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColor: Colors.brown,
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      ),
    );
  }
}

class LikeButtonWidget extends StatefulWidget {
  const LikeButtonWidget({Key? key}) : super(key: key);

  @override
  _LikeButtonWidgetState createState() => _LikeButtonWidgetState();
}

class _LikeButtonWidgetState extends State<LikeButtonWidget> {
  bool isLiked = false;
  int likeCount = 331;

  @override
  Widget build(BuildContext context) {
    const double size = 20;

    return LikeButton(
      size: size,
      isLiked: isLiked,
      likeCount: likeCount,
      circleColor: const CircleColor(start: Colors.blue, end: Colors.blue),
      bubblesColor: const BubblesColor(
        dotPrimaryColor: Colors.blue,
        dotSecondaryColor: Colors.lightBlueAccent,
      ),
      likeBuilder: (isLiked) {
        return Icon(
          Icons.thumb_up,
          color: isLiked ? Colors.blue : Colors.grey,
          size: size,
        );
      },
      countBuilder: (count, isLiked, text) {
        return Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Oxygen',
            color: isLiked ? Colors.blue : Colors.grey,
          ),
        );
      },
    );
  }
}
