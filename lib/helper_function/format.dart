import 'package:intl/intl.dart';

//! DATES

String ddMMyy(DateTime date) => DateFormat('dd/MM/yyyy').format(date);
String ddMMMyy(DateTime date) => DateFormat('dd/MMM/yyyy').format(date);
String specialFormate(DateTime date, String format) => DateFormat(format).format(date);

//! CURRENCY
String indianFormat(double number) => NumberFormat.currency(
      name: "INR",
      locale: 'en_IN',
      decimalDigits: 0, // change it to get decimal places
      symbol: '₹',
    ).format(number);

//! twoDigit
String twoDigitPer(double _) {
  return (_ * 100).toStringAsFixed(2);
}
