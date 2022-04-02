import 'dart:async';

import 'package:flutter/material.dart';
import 'package:itunes_music_preview/widget/app_text.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/2/2022.

class ScrollingText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Axis scrollAxis;
  final double ratioOfBlankToScreen;
  final double height;

  const ScrollingText(this.text,
      {required this.style,
      required this.height,
      this.scrollAxis = Axis.horizontal,
      this.ratioOfBlankToScreen = 0.25,
      Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ScrollingTextState();
  }
}

class ScrollingTextState extends State<ScrollingText>
    with SingleTickerProviderStateMixin {
  late ScrollController scrollController;
  late double screenWidth;
  late double screenHeight;
  double position = 0.0;
  Timer? timer;
  final double _moveDistance = 3.0;
  final int _timerRest = 100;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    WidgetsBinding.instance?.addPostFrameCallback((callback) {
      startTimer();
    });
  }

  void startTimer() {
    if (_key.currentContext != null) {
      double widgetWidth =
          _key.currentContext?.findRenderObject()?.paintBounds.size.width ?? 0;
      double widgetHeight =
          _key.currentContext?.findRenderObject()?.paintBounds.size.height ?? 0;

      timer = Timer.periodic(Duration(milliseconds: _timerRest), (timer) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;
        double pixels = scrollController.position.pixels;
        if (pixels + _moveDistance >= maxScrollExtent) {
          if (widget.scrollAxis == Axis.horizontal) {
            position = (maxScrollExtent -
                        screenWidth * widget.ratioOfBlankToScreen +
                        widgetWidth) /
                    2 -
                widgetWidth +
                pixels -
                maxScrollExtent;
          } else {
            position = (maxScrollExtent -
                        screenHeight * widget.ratioOfBlankToScreen +
                        widgetHeight) /
                    2 -
                widgetHeight +
                pixels -
                maxScrollExtent;
          }
          scrollController.jumpTo(position);
        }
        position += _moveDistance;
        scrollController.animateTo(position,
            duration: Duration(milliseconds: _timerRest), curve: Curves.linear);
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
  }

  Widget getBothEndsChild() {
    if (widget.scrollAxis == Axis.vertical) {
      String newString = widget.text.split("").join("\n");
      return Center(
        child: Text(
          newString,
          style: widget.style,
          textAlign: TextAlign.center,
        ),
      );
    }
    return Center(
        child: Text(
      widget.text,
      style: widget.style,
    ));
  }

  Widget getCenterChild() {
    if (widget.scrollAxis == Axis.horizontal) {
      return Container(width: screenWidth * widget.ratioOfBlankToScreen);
    } else {
      return Container(height: screenHeight * widget.ratioOfBlankToScreen);
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return _drawText(
        context: context,
        scrollableView: ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: widget.height, maxHeight: widget.height),
          child: SizedBox(
            width: double.infinity,
            child: ListView(
              key: _key,
              scrollDirection: widget.scrollAxis,
              controller: scrollController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                getBothEndsChild(),
                getCenterChild(),
                getBothEndsChild(),
              ],
            ),
          ),
        ));
  }

  Widget _drawText(
      {required BuildContext context, required Widget scrollableView}) {
    return LayoutBuilder(builder: (context, size) {
      ///Build TextSpan for calculation purpose
      var span = TextSpan(
        text: widget.text,
        style: widget.style,
      );

      ///Use TextPainter to determine if it will exceed max lines
      final textPainter = TextPainter(
        maxLines: 1,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
        text: span,
      );

      ///Trigger TextPainter into layout
      textPainter.layout(maxWidth: size.maxWidth);

      ///Check whether the text overflowed or not
      final isOverflowed = textPainter.didExceedMaxLines;

      ///Return adaptive widget
      return isOverflowed
          ? scrollableView
          : AppText(
              widget.text,
              style: widget.style,
            );
    });
  }
}
