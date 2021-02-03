import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xshop_mobile/screens/customer/products/product_details.dart';
import 'package:xshop_mobile/services/search_prduct.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:xshop_mobile/models/product.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(
          Icons.close,
          color: AppTheme.colors.secondry,
        ),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: AppTheme.colors.primary)),
      primaryColor: AppTheme.colors.primaryLight,
    );
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: AppTheme.colors.secondry),
      onPressed: () {
        Navigator.pop(context);
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
    if (query.isEmpty)
      return Center(child: Text('serach for product by id'));
    else {
      return FutureBuilder<Product>(
          future: fetchProductsID(http.Client(), query),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return snapshot.data.name == "notfound"
                  ? Center(
                      child: Text(
                      'product not found!',
                      style: TextStyle(fontSize: 18, color: Colors.red[700]),
                    ))
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                      ),
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                    product: snapshot.data,
                                  ),
                                  fullscreenDialog: true,
                                ),
                              );
                            },
                            child: Container(
                                padding: EdgeInsets.all(20),
                                child: Card(
                                    elevation: 3,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                    color: AppTheme.colors.primaryLight,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(18.0),
                                            border: Border.all(
                                                color: AppTheme.colors.secondry,
                                                width: 3)),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text('${snapshot.data.name}',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: AppTheme
                                                          .colors.primary)),
                                              Text('${snapshot.data.price} EGP',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.red[900]))
                                            ])))));
                      });
            } else
              return Center(
                  child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    AppTheme.colors.primaryLight),
                backgroundColor: AppTheme.colors.primary,
              ));
          });
    }
  }
}
