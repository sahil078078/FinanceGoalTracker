import '../exported.dart';

///! Formatter
// Mobile
final mobileInputFormatter = [FilteringTextInputFormatter.allow(RegExp('[0-9]'))];
final realNumberFormatter = [
  // allow only 0 to 9
  // allow real value with decimal and positive
  // only 2 decimal allow
  FilteringTextInputFormatter.allow(
    RegExp(r'^\d+\.?\d{0,2}'),
  ),
];

///! Validators

// MobileNUmber
String? mobileNumValidator(phone) {
  if (phone == null || phone.trim().isEmpty) {
    return "Please enter mobile number";
  } else {
    if (phone.toString().startsWith('0')) {
      return "Mobile number not start with zero";
    } else if (phone.trim().length != 10) {
      return "Invalid number";
    } else {
      return null;
    }
  }
}

//Amount
String? amountValidator(rate) {
  if (rate != null && rate.trim().isNotEmpty) {
    final x = double.tryParse(rate.trim()) ?? 0;

    if (x <= 0) {
      return "Invalid amount";
    } else {
      return null;
    }
  }
  return "Please enter amount";
}
