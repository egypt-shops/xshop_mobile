import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xshop_mobile/screens/login/components/login_screen.dart';
import 'package:xshop_mobile/screens/login/login.dart';

void main() {
  testWidgets('login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(Login());
    final mobileFinder = find.widgetWithText(TextFormField, 'Mobile');
    final passwdFinder = find.widgetWithText(TextFormField, 'Password');
    final btnFinder = find.byType(RaisedButton);

    expect(mobileFinder, findsOneWidget);
    expect(passwdFinder, findsOneWidget);
    expect(btnFinder, findsOneWidget);

    await tester.enterText(mobileFinder, 'num');
    await tester.enterText(passwdFinder, 'pass');
    //await tester.tap(btnFinder);

    //expect(mobileController.text, 'num');
    //expect(passwordController.text, 'pass');
  });
}
