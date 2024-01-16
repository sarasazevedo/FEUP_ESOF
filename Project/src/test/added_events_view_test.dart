import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:eventfully/tabs/added_events_view.dart';

void main() {
  group('AddedEventsView', () {
    testWidgets('displays "You haven\'t created any event."', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddedEventsView()));

      expect(find.text('You haven\'t created any event.'), findsOneWidget);
    });

    testWidgets('displays "To create an event click on the [icon] in your profile page!"', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: AddedEventsView()));

      final iconFinder = find.byIcon(Icons.add_box_outlined);

      expect(iconFinder, findsOneWidget);

      final textFinder = find.text('To create an event click on the');

      expect(textFinder, findsOneWidget);

      final lastTextFinder = find.text('your profile page!');

      expect(lastTextFinder, findsOneWidget);
    });
  });
}
