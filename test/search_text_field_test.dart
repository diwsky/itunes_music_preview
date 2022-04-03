import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_music_preview/widget/search_text_field.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

void main() {
  Widget wrapWithScaffold(SearchTextField widget) =>
      MaterialApp(home: Scaffold(body: widget));

  group("Widget Build", () {
    testWidgets("TextField build placeholder successfully",
        (WidgetTester tester) async {
      const suffixIcon = Icons.check_circle;

      ///Build widget
      await tester.pumpWidget(wrapWithScaffold(const SearchTextField(
        placeholder: "placeholder",
        suffixIcon: Icon(suffixIcon),
      )));

      ///Expect widget build successfully with provided [suffixIcon]
      expect(find.text("placeholder"), findsOneWidget);
    });

    testWidgets("TextField build successfully without controller",
        (WidgetTester tester) async {
      ///Build widget
      await tester
          .pumpWidget(wrapWithScaffold(const SearchTextField(placeholder: "")));

      ///Expect widget build successfully
      expect(find.byType(SearchTextField), findsOneWidget);
    });

    testWidgets("TextField build suffixIcon successfully",
        (WidgetTester tester) async {
      const suffixIcon = Icons.check_circle;

      ///Build widget
      await tester.pumpWidget(wrapWithScaffold(const SearchTextField(
        placeholder: "",
        suffixIcon: Icon(suffixIcon),
      )));

      ///Expect widget build successfully with provided [suffixIcon]
      expect(find.byIcon(suffixIcon), findsOneWidget);
    });
  });

  group("Event Listener", () {
    String textTypedByUser = "";

    testWidgets("Should invoke function when user typing",
        (WidgetTester tester) async {
      ///Build Widget
      await tester.pumpWidget(wrapWithScaffold(SearchTextField(
        placeholder: "",
        onChanged: (text) => textTypedByUser = text,
      )));

      ///Simulate entering text into [SearchTextField]
      await tester.enterText(
          find.byType(SearchTextField), "Too good to be true");
      await tester.pump();

      ///Expected [textTypedByUser] changed
      expect(textTypedByUser, equals("Too good to be true"));
    });

    testWidgets("Should invoke function when TextField submitted",
        (WidgetTester tester) async {
      ///Build Widget
      await tester.pumpWidget(wrapWithScaffold(SearchTextField(
        placeholder: "",
        onSearch: (text) => textTypedByUser = text,
      )));

      ///Simulate entering text into [SearchTextField]
      await tester.enterText(
          find.byType(SearchTextField), "Search for something");

      ///Simulate user click on submit button
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      ///Expected [textTypedByUser] changed
      expect(textTypedByUser, equals("Search for something"));
    });
  });
}
