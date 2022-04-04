import 'package:intl/intl.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 4/4/2022.


extension DateTimeExt on DateTime {
  /// Doc : Covert [DateTime] toString with format [dd-MMM-yyyy].
  /// @author rizkyagungramadhan@gmail.com on 04-Apr-2022, Mon, 13:02.
  String toCompactDate([String dateSeparator = " "]) {
    final format = DateFormat("dd${dateSeparator}MMM${dateSeparator}yyyy");
    return format.format(this);
  }
}