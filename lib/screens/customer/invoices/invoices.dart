import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/screens/customer/invoices/invoice_details.dart';
import 'package:xshop_mobile/services/invoices.dart';
import 'package:xshop_mobile/screens/customer/invoices/search.dart';
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
      backgroundColor: AppTheme.colors.primaryLight,
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
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
            ),
          ]),
      body: FutureBuilder<List<Invoice>>(
        future: fetchInvoices(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? InvoicesList(invoices: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                      AppTheme.colors.primaryLight),
                  backgroundColor: AppTheme.colors.primary,
                ));
        },
      ),
    ));
  }
}

class InvoicesList extends StatelessWidget {
  final List<Invoice> invoices;

  InvoicesList({Key key, this.invoices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView(itemExtent: 450, children: [
      ...invoices.map((Invoice index) {
        return Container(
            height: 450,
            width: 300,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/invoice.png"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(5),
            child: Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InvoiceDetails(
                            invoice: index,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                        width: 260,
                        height: 403,
                        color: AppTheme.colors.secondry,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('user: ${index.user}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.colors.textSecondry)),
                              Text('order: ${index.order} ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.colors.textSecondry)),
                              RaisedButton(
                                  child: Text("details"),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => InvoiceDetails(
                                          invoice: index,
                                        ),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  })
                            ])))));
      })
    ]);
  }
}
