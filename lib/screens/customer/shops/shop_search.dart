import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';
import 'package:xshop_mobile/screens/customer/shops/shops.dart';
import 'package:xshop_mobile/services/search_shop.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;
import 'package:xshop_mobile/screens/home/components/customer.dart';

class ShopsSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        key: Key("clear shop search"),
        icon: Icon(
          Icons.close,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  String selectedResult = "";

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Shop> suggestions = query.isEmpty
        ? shops
        : shops
            .where((element) =>
                element.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
    if (suggestions != null)
      return ShopSearchList(suggestions: suggestions);
    else {
      return Center(
        child: Text('no Shops'),
      );
    }
  }
}

class ShopSearchList extends StatelessWidget {
  final List<Shop> suggestions;
  ShopSearchList({Key key, this.suggestions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ShopDetails(shops[index].id, shops[index].name)),
              );
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(5.0, 2.5, 5, 2.5),
              height: 200,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(5.0, 0, 0.0, 0.0),
                            width: 120,
                            height: 140,
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage('images/try.jpg'),
                                fit: BoxFit.fill,
                              ),
                              border: Border.all(
                                color: Colors.teal[900],
                                width: 0,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 10.0, 0.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${suggestions[index].name}',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      color: AppTheme.colors.primary,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'the shop is fantastic , ',
                                  style: TextStyle(fontSize: 12),
                                  softWrap: true,
                                ),
                                SizedBox(
                                  height: 70,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.orange,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.orange,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.orange,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.orange,
                                    ),
                                    Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 20.0,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.favorite_border_rounded,
                                color: Colors.grey,
                                size: 25,
                              ),
                              onPressed: () {})
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
