import 'package:intl/intl.dart' show NumberFormat;

extension NumberFormatter on int {
  String compact() {
    const String pattern = '#,##0; - #,##0';

    final formatter = NumberFormat(pattern);

    formatter.maximumFractionDigits = 0;

    return formatter.format(this);
  }
}
