import 'dart:async';

import 'package:eventfully/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mockito/mockito.dart';

import 'package:eventfully/pages/home_page.dart';
import 'package:eventfully/pages/auth_page.dart';
import 'package:eventfully/main.dart';

class MockFirebaseApp extends Mock implements FirebaseApp {}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('MyApp', () {
    FirebaseApp firebaseApp;
    MockFirebaseApp mockFirebaseApp;

    setUpAll(() async {
  firebaseApp = await Firebase.initializeApp(
    options: FirebaseOptions(
      appId: 'testAppId',
      apiKey: 'testApiKey',
      projectId: 'testProjectId',
      messagingSenderId: 'testMessagingSenderId', // add this parameter
    ),
  );
  mockFirebaseApp = MockFirebaseApp();
  when(mockFirebaseApp.options).thenReturn(DefaultFirebaseOptions.currentPlatform);
  final completer = Completer<FirebaseApp>();
completer.complete(mockFirebaseApp);
when(Firebase.initializeApp(options: anyNamed('options')))
    .thenAnswer((_) => completer.future);

});


    tearDownAll(() async {
      await Firebase.app().delete();
    });

    testWidgets('Navigate to AuthPage and back to HomePage', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      // Wait for the StartPage to load
      await tester.pumpAndSettle();

      // Tap the AuthPage navigation item
      await tester.tap(find.byIcon(Icons.account_circle));
      await tester.pumpAndSettle();

      // Verify that the AuthPage is now being displayed
      expect(find.byType(AuthPage), findsOneWidget);

      // Tap the HomePage navigation item
      await tester.tap(find.byIcon(Icons.home_rounded));
      await tester.pumpAndSettle();

      // Verify that the HomePage is now being displayed
      expect(find.byType(HomePage), findsOneWidget);
    });
  });
}
