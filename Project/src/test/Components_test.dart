import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventfully/Components/Components.dart';

void main() {
  testWidgets('LoginTextField should show hintText',
      (WidgetTester tester) async {
    const hintText = 'Enter your username';
    final controller = TextEditingController();
    final obscureText = false;
    final max = 1;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LoginTextField(
          controller: controller,
          hintText: hintText,
          obscureText: obscureText,
          max: max,
        ),
      ),
    ));

    final hintFinder = find.text(hintText);
    expect(hintFinder, findsOneWidget);
  });

  testWidgets('LoginTextField should show entered text',
      (WidgetTester tester) async {
    final controller = TextEditingController();
    const enteredText = 'John Doe';
    final obscureText = false;
    final max = 1;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LoginTextField(
          controller: controller,
          hintText: 'Enter your name',
          obscureText: obscureText,
          max: max,
        ),
      ),
    ));

    await tester.enterText(find.byType(TextField), enteredText);

    expect(controller.text, equals(enteredText));
  });
}
