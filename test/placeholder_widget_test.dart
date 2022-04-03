import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:itunes_music_preview/common/placeholder_type.dart';
import 'package:itunes_music_preview/widget/placeholder_widget.dart';
import 'package:lottie/lottie.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.

void main() {
  testWidgets("Build animation with specific height",
      (WidgetTester tester) async {
    double preferredHeight = 100.0;

    ///Build widget
    await tester.pumpWidget(MaterialApp(
        home: PlaceholderWidget(
      type: PlaceholderType.typeASearch,
      animationHeight: preferredHeight,
    )));

    ///Get animation height
    final animationHeight = tester.getSize(find.byType(Lottie)).height;

    ///Expect [animationHeight] equals to [preferredHeight]
    expect(animationHeight, equals(preferredHeight));
  });

  testWidgets("Build widget with TypeASearch type",
      (WidgetTester tester) async {
    ///Build widget
    await tester.pumpWidget(const MaterialApp(
        home: PlaceholderWidget(
      type: PlaceholderType.typeASearch,
    )));

    ///Expect animation build successfully
    expect(find.byType(Lottie), findsOneWidget);
    ///Expect text build successfully
    expect(find.text("Please search music from your favorite artist"), findsOneWidget);
  });

  testWidgets("Build widget with NoData type",
          (WidgetTester tester) async {
        ///Build widget
        await tester.pumpWidget(const MaterialApp(
            home: PlaceholderWidget(
              type: PlaceholderType.noData,
            )));

        ///Expect animation build successfully
        expect(find.byType(Lottie), findsOneWidget);
        ///Expect text build successfully
        expect(find.text("No data found"), findsOneWidget);
      });

  testWidgets("Build widget with NoConnection type",
          (WidgetTester tester) async {
        ///Build widget
        await tester.pumpWidget(const MaterialApp(
            home: PlaceholderWidget(
              type: PlaceholderType.noConnection,
            )));

        ///Expect animation build successfully
        expect(find.byType(Lottie), findsOneWidget);
        ///Expect text build successfully
        expect(find.text("No connection available"), findsOneWidget);
      });

  testWidgets("Build widget with SomethingWentWrong type",
          (WidgetTester tester) async {
        ///Build widget
        await tester.pumpWidget(const MaterialApp(
            home: PlaceholderWidget(
              type: PlaceholderType.somethingWentWrong,
            )));

        ///Expect animation build successfully
        expect(find.byType(Lottie), findsOneWidget);
        ///Expect text build successfully
        expect(find.text("Oops something went wrong"), findsOneWidget);
      });
}
