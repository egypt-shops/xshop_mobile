import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:xshop_mobile/models/favorites.dart';
import 'package:xshop_mobile/screens/home/home.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';

SharedPreferences sharedPreferences;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(Xshop());
}

class Xshop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => FavoritesShops()),
          ChangeNotifierProvider(create: (context) => FavoritesProducts()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'xshop',
          theme: ThemeData(
            // Define the default brightness and colors.
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.white),
            primaryColor: Colors.amber[800],
            secondaryHeaderColor: Colors.white,
            accentColor: Colors.amber[800],
            focusColor: Colors.white70,
            scaffoldBackgroundColor: Colors.grey[100],
            backgroundColor: Colors.grey[700],
            // Define the default font family.

            // Define the default TextTheme. Use this to specify the default
            // text styling for headlines, titles, bodies of text, and more.
            textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                headline6: TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                ),
                bodyText2: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Raleway',
                    color: Colors.grey[600]),
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Hind',
                    color: Colors.white70)),
          ),
          routes: {
            '/': (context) => Home(),
            '/login': (context) => LoginScreen(),
          },
        ));
  }
}
