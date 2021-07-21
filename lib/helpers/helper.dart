import 'package:intl/intl.dart';

class Helper {
  static toDateFormat(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('MMMM dd, yyyy');
    return dateFormat.format(dateTime);
  }

  static toTimeFormat(DateTime dateTime) {
    DateFormat dateFormat = DateFormat('HH:mm');
    return dateFormat.format(dateTime);
  }
}
