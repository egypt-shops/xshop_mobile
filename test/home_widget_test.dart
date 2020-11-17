import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xshop_mobile/screens/home/home.dart';

void main() {
  testWidgets('home screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Home());

    final logoutFinder = find.byType(FlatButton);
    

    expect(logoutFinder, findsOneWidget);

    await tester.tap(logoutFinder);

  });
}
