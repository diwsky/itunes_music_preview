import 'package:flutter/cupertino.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/1/2022.

extension WidgetExt on Widget {
  Widget asScrollable() => SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: this,
      );
}
