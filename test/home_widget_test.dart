import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xshop_mobile/screens/home/home.dart';

void main() {
  testWidgets('login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Home());

    final logoutFinder = find.byType(FlatButton);
    final welcomeFinder = find.text('login successfully');
    

    expect(logoutFinder, findsOneWidget);
    expect(welcomeFinder, findsOneWidget);
    await tester.tap(logoutFinder);

  });
}
