import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/shop_details.dart';
import 'package:xshop_mobile/services/search_shop.dart';
import 'package:xshop_mobile/models/shop.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

class ShopsSearch extends SearchDelegate {
  Shop shopById;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.close,
          color: AppTheme.colors.secondry,
          size: 30,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        color: AppTheme.colors.secondry,
        icon: Icon(
          Icons.arrow_back,
          size: 30,
        ),
        onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Center(
        child: Text(
          'search for shops by ID',
          style: TextStyle(fontSize: 18, color: Colors.red),
        ),
      );
    } else {
      return FutureBuilder<Shop>(
          future: fetchShopByID(http.Client(), query),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return snapshot.data.name == 'notFound'
                  ? Center(
                      child: Text(
                        'Not Found',
                        style: TextStyle(fontSize: 18, color: Colors.red[700]),
                      ),
                    )
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ShopDetails(shop: snapshot.data)),
                            );
                          },
                          child: Card(
                            color: AppTheme.colors.primaryLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            margin: EdgeInsets.fromLTRB(40.0, 40.0, 40.0, 40.0),
                            child: Container(
                              decoration: BoxDecoration(
                                // be the same as radius of card
                                borderRadius: BorderRadius.circular(18.0),
                                border: Border.all(
                                    color: AppTheme.colors.secondry, width: 3),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '${snapshot.data.name}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: AppTheme.colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    '${snapshot.data.name}',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        color: AppTheme.colors.primary,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.teal.shade300,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.teal.shade300,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.teal.shade300,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.teal.shade300,
                                      ),
                                      Icon(
                                        Icons.star,
                                        size: 20.0,
                                        color: Colors.teal.shade300,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
            } else
              return Center(child: CircularProgressIndicator());
          });
    }
  }
}
