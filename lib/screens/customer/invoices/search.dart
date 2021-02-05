import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/services/search_invoice.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

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
      return Center(child: Text('serach for invoice by id'));
    else {
      return FutureBuilder<Invoice>(
          future: fetchInvoicesID(http.Client(), query),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            if (snapshot.hasData) {
              return snapshot.data.user == 0
                  ? Center(
                      child: Text(
                      'invoice not found!',
                      style: TextStyle(fontSize: 18, color: Colors.red[700]),
                    ))
                  : Center(
                      child: Container(
                          height: 450,
                          width: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("images/invoice.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: Container(
                                  width: 260,
                                  height: 385,
                                  color: AppTheme.colors.secondry,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text('user: ${snapshot.data.user}',
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: AppTheme
                                                    .colors.textSecondry)),
                                        Text('order: ${snapshot.data.order} ',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: AppTheme
                                                    .colors.textSecondry))
                                      ])))));
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
