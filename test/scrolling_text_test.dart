import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_music_preview/widget/scrolling_text.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

void main() {
  group("Scrolling Text State", () {
    testWidgets("Show general text when text is not overflowed",
        (WidgetTester tester) async {

      ///Pump [ScrollingText] with short text
      await tester.pumpWidget(const MaterialApp(
        home: ScrollingText("Short text", style: TextStyle(), height: 10),
      ));

      ///Expected only have one [Text] widget
      expect(find.byType(Text), findsOneWidget);

      ///Expected not generating [ListView] since the text is short
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets("Show scrolling text when text is overflowed",
        (WidgetTester tester) async {

      ///Pump [ScrollingText] with a long text
      await tester.pumpWidget(const MaterialApp(
        home: ScrollingText(
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna",
            style: TextStyle(),
            height: 10),
      ));

      ///Expect text is showing in [Text] widget
      expect(find.byType(Text), findsOneWidget);

      ///Expect [ListView] widget generated when text is too long to show up scrollable text in single line
      expect(find.byType(ListView), findsOneWidget);
    });
  });
}
