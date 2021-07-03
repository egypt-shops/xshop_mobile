import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xshop_mobile/screens/data_entry/search.dart';
import 'package:xshop_mobile/screens/home/components/customer.dart';
import 'package:xshop_mobile/screens/home/components/data_entry_clerk.dart';

void main() {
  testWidgets('customer home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Customer()));

    final searchButton = find.byKey(ValueKey("search for shop"));
    final shops = find.text("Home");
    final invoices = find.text("Invoices");
    final orders = find.text("Orders");

    expect(searchButton, findsOneWidget);
    expect(shops, findsOneWidget);
    expect(invoices, findsOneWidget);
    expect(orders, findsOneWidget);

    await tester.tap(searchButton);
    await tester.tap(shops);
    await tester.tap(invoices);
    await tester.tap(orders);
    //await tester.pump();
    //final searchScreen = find.byKey(ValueKey("clear shop search"));
    //expect(searchScreen, findsOneWidget);
  });
}
