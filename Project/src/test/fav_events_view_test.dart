import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:eventfully/tabs/fav_events_view.dart';

void main() {
  group('FavEventsView', () {
    testWidgets('should render without exploding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FavEventsView(),
        ),
      );
    });

    testWidgets('should display the correct text', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FavEventsView(),
        ),
      );

      expect(find.text("You haven't favorited any event."), findsOneWidget);
      expect(
          find.text("To favorite an event click on the"), findsOneWidget);
      expect(find.byIcon(Icons.add_box_outlined), findsOneWidget);
      expect(find.text("in an event"), findsOneWidget);
      expect(find.text("in your home page!"), findsOneWidget);
    });
  });
}
