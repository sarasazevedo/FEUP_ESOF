import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventfully/pages/home_page.dart';

void main() {
  testWidgets('HomePage returns a Scaffold', (WidgetTester tester) async {
    // Build the HomePage widget.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Expect to find a Scaffold widget.
    expect(find.byType(Scaffold), findsOneWidget);
  });
}