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
    final loginFinder = find.widgetWithText(RaisedButton, 'LOGIN');
    final signupFinder = find.widgetWithText(RaisedButton, 'SIGNUP');

    expect(mobileFinder, findsOneWidget);
    expect(passwdFinder, findsOneWidget);
    expect(loginFinder, findsOneWidget);
    expect(signupFinder, findsOneWidget);
    expect(find.byKey(Key("Sign In indicator")), findsNothing);

    await tester.enterText(mobileFinder, 'num');
    await tester.enterText(passwdFinder, 'pass');
    await tester.tap(loginFinder);
    //expect(find.byKey(Key("Sign In indicator")), findsOneWidget);
    expect(mobileController.text, 'num');
    expect(passwordController.text, 'pass');
  });
  testWidgets('login api test', (WidgetTester tester) async {});
}
