import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/shops/shop_details.dart';
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
                          child: Container(
                            padding: EdgeInsets.fromLTRB(8.0, 20, 8, 2.5),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              5.0, 0, 0.0, 0.0),
                                          width: 120,
                                          height: 180,
                                          decoration: BoxDecoration(
                                            image: const DecorationImage(
                                              image:
                                                  AssetImage('images/try.jpg'),
                                              fit: BoxFit.fill,
                                            ),
                                            border: Border.all(
                                              color: Colors.teal[900],
                                              width: 0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              0, 0, 10.0, 0.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '${snapshot.data.name}',
                                                style: TextStyle(
                                                    fontSize: 18.0,
                                                    color:
                                                        AppTheme.colors.primary,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
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
                          /*



                           */
                        );
                      });
            } else
              return Center(child: CircularProgressIndicator());
          });
    }
  }
}
