import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/screens/customer/invoices/invoice_details.dart';
import 'package:xshop_mobile/services/invoices.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

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
            body: InvoiceApi()));
  }
}

class InvoicesList extends StatelessWidget {
  final List<Invoice> invoices;

  InvoicesList({Key key, this.invoices}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => GetInvoice(invoices[index].id)));
          },
          child: Container(
              height: 150,
              padding: EdgeInsets.all(3),
              child: Card(
                  elevation: 1,
                  color: Theme.of(context).secondaryHeaderColor,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('user: ${invoices[index].user}',
                            style: TextStyle(
                                fontSize: 20, color: AppTheme.colors.primary)),
                        Text('order: ${invoices[index].order} ',
                            style:
                                TextStyle(fontSize: 12, color: Colors.red[900]))
                      ]))));
    }, childCount: invoices.length));
  }
}
