import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xshop_mobile/screens/data_entry/edit_product.dart';
import 'package:xshop_mobile/screens/data_entry/product_creating.dart';
import 'package:xshop_mobile/screens/home/components/data_entry_clerk.dart';

void main() {
  // test first page of data entry clerk
  testWidgets('DataEntry UI check', (WidgetTester tester) async {
    // build and trigger
    await tester.pumpWidget(MaterialApp(home: DataEntryClerk()));
    expect(find.text('welcome to Xshop'), findsOneWidget);

    // checks Icons Button
    await tester.tap(find.byIcon(Icons.search));
    await tester.tap(find.byIcon(Icons.person));
    await tester.tap(find.byIcon(Icons.store));
    await tester.tap(find.byIcon(Icons.add_box));
  });

  // testWidgets('Drawer check', (WidgetTester tester) async {
  //   final DataEntry_Scaffold = GlobalKey<ScaffoldState>();
  //   // find widgets
  //   await tester.pumpWidget(MaterialApp(
  //       home: Scaffold(
  //     key: DataEntry_Scaffold,
  //     drawer: Drawer(
  //       key: Key('DataEntry_Drawer'),
  //     ),
  //   )));
  //   await tester.tap(find.byIcon(Icons.person));
  //   await tester.pump();
  //
  //   // expect(find.text('Mohamed Boyka'), findsOneWidget);
  //   // output after taping person Icon
  //   expect(find.text('home'), findsOneWidget);
  //   //expect(find.text('Mohamed Boyka'), findsOneWidget);
  //   //expect(find.text('account user'), findsOneWidget);
  //   //expect(find.text('about'), findsOneWidget);
  // });
  // test the ui of ProductCreatingPage
  testWidgets('Create product UI', (WidgetTester tester) async {
    await tester.pumpWidget((ProductCreatingPage()));

    expect(find.text('name :'), findsOneWidget);
    expect(find.text('Price :'), findsOneWidget);
    expect(find.text('stock :'), findsOneWidget);
    expect(find.text('description :'), findsOneWidget);

    await tester.enterText(find.byKey(ValueKey('name_controller')), 'one cup');
    await tester.enterText(find.byKey(ValueKey('price_controller')), '5');
    await tester.enterText(find.byKey(ValueKey('stock_controller')), 'Aswan');
    await tester.enterText(
        find.byKey(ValueKey('description_controller')), 'has only one');

    // await tester.tap(find.byKey(ValueKey('Create_Product')));
    //await tester.tap(find.byKey(ValueKey('save_Product')));
  });
}
