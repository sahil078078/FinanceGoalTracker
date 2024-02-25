import '../exported.dart';

Future<DateTime?> getDate({
  required BuildContext context,
  DateTime? initialDate,
  DateTime? lastDate,
  String? pickerTile,
}) async {
  DateTime? date = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime(1950, 1, 1),
    lastDate: lastDate ?? DateTime(2099),
    helpText: pickerTile ?? "Select completion date",
    barrierDismissible: false,
    builder: (context, child) {
      return Theme(
        data: ThemeData(
          useMaterial3: true,
          colorScheme: Theme.of(context).colorScheme,
          primaryColor: Theme.of(context).primaryColor,
          fontFamily: 'Inter',
        ),
        child: child ?? const SizedBox.shrink(),
      );
    },
  );

  return date;
}
