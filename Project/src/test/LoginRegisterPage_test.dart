import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:eventfully/pages/login_page.dart';
import 'package:eventfully/pages/register_page.dart';
import 'package:eventfully/pages/login_register_page.dart';

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  group('LoginRegisterPage widget', () {
    late NavigatorObserver mockObserver;

    setUp(() {
      mockObserver = MockNavigatorObserver();
    });

    testWidgets('initial page is LoginPage', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginRegisterPage(),
        navigatorObservers: [mockObserver],
      ));

      expect(find.byType(LoginPage), findsOneWidget);
    });

    testWidgets('tap on RegisterPage button navigates to RegisterPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginRegisterPage(),
        navigatorObservers: [mockObserver],
      ));

      // Tap the button to show the RegisterPage
      await tester.tap(find.text('Don\'t have an account? Sign up here.'));

      // Rebuild the widget with the new page
      await tester.pumpAndSettle();

      // Verify that the RegisterPage is shown
      expect(find.byType(RegisterPage), findsOneWidget);

      // Verify that the navigator pushed a new route
      verify(mockObserver.didPush(any!, any!));
    });

    testWidgets('tap on LoginPage button navigates to LoginPage',
        (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: LoginRegisterPage(),
        navigatorObservers: [mockObserver],
      ));

      // Navigate to the RegisterPage
      await tester.tap(find.text('Don\'t have an account? Sign up here.'));
      await tester.pumpAndSettle();

      // Tap the button to show the LoginPage
      await tester.tap(find.text('Already have an account? Log in here.'));

      // Rebuild the widget with the new page
      await tester.pumpAndSettle();

      // Verify that the LoginPage is shown
      expect(find.byType(LoginPage), findsOneWidget);

      // Verify that the navigator pushed a new route
      verify(mockObserver.didPush(any!, any!));
    });
  });
}
