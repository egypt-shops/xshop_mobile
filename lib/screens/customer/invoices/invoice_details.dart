import 'package:flutter/material.dart';
import 'package:xshop_mobile/models/invoice.dart';
import 'package:xshop_mobile/theme/apptheme.dart';

class InvoiceDetails extends StatefulWidget {
  final Invoice invoice;

  InvoiceDetails({Key key, this.invoice}) : super(key: key);
  @override
  _InvoiceDetailsState createState() => _InvoiceDetailsState();
}

class _InvoiceDetailsState extends State<InvoiceDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.colors.primary,
        ),
        body: Center(
            child: Container(
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
                    child: Container(
                        width: 260,
                        height: 403,
                        color: AppTheme.colors.secondry,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('user: ${widget.invoice.user}',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.colors.textSecondry)),
                              Text('order: ${widget.invoice.order} ',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppTheme.colors.textSecondry))
                            ]))))));
  }
}
