import 'package:intl/intl.dart';

extension StringExtensions on String {
  DateTime getTime() {
    var timeFormat = DateFormat("dd-MM-yyyy hh:mm:ss");

    return timeFormat.parse(this);
  }
}
