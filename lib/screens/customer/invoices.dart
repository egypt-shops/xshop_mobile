import 'package:flutter/material.dart';
import 'package:xshop_mobile/services/invoices.dart';
import 'package:xshop_mobile/theme/apptheme.dart';
import 'package:http/http.dart' as http;

class Invoices extends StatefulWidget {
  @override
  _InvoicesState createState() => _InvoicesState();
}

class _InvoicesState extends State<Invoices> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AppTheme.colors.primary,
                iconTheme: IconThemeData(color: AppTheme.colors.secondry),
                title: Text("Invoices"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: AppTheme.colors.secondry,
                    ),
                    tooltip: 'Search',
                    onPressed: null,
                  ),
                ]),
            body: Center(
              child: FutureBuilder<List<Product>>(
                future: fetchInvoices(http.Client()),
                builder: (context, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);

                  return snapshot.hasData
                      ? InvoicesList(invoices: snapshot.data)
                      : Center(child: CircularProgressIndicator());
                },
              ),
            )));
  }
}

class InvoicesList extends StatelessWidget {
  final List<Product> invoices;

  InvoicesList({Key key, this.invoices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: invoices.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {},
            child: Container(
                padding: EdgeInsets.all(3),
                child: Card(
                    elevation: 5,
                    color: AppTheme.colors.primaryLight,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('user: ${invoices[index].user}',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppTheme.colors.primary)),
                          Text('order: ${invoices[index].order} ',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.red[900]))
                        ]))));
      },
    );
  }
}
