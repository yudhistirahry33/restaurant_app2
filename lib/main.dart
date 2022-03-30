import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/ui/information_page.dart';
import 'package:restaurant_app/data/model/models.dart';

var appBarText = const TextStyle(
    fontSize: 25, fontFamily: 'Staatliches', color: Colors.white);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Indonesian Best Resto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: primaryColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        ),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        InformationPage.routeName: (context) => InformationPage(
          id: ModalRoute.of(context)!.settings.arguments == null
              ? 'null'
              : ModalRoute.of(context)!.settings.arguments as String,
            ),
      },
    );
  }
}
