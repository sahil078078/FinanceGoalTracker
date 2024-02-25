import 'package:flutter/material.dart';

//! We used name route for navigation

//* next screen
Future<T?> nextScreen<T extends Object?>({
  required BuildContext context,
  required String routeName,
  Object? arguments,
}) async =>
    await Navigator.pushNamed(context, routeName, arguments: arguments);

//* popScreen/BackScreen
void backScreen<T extends Object?>({required BuildContext context, T? result}) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop(result);
  }
}

//* PushAndReplace
Future<T?> pushNReplace<T extends Object?, TO extends Object?>({
  required BuildContext context,
  required String routeName,
  TO? result,
  Object? arguments,
}) async =>
    await Navigator.pushReplacementNamed(
      context,
      routeName,
      arguments: arguments,
      result: result,
    );

//* PushNRremoveUntil
Future<T?> pushNRemoveUntil<T extends Object?>({
  required BuildContext context,
  required String newRouteName,
  bool Function(Route<dynamic>)? predicate,
  Object? arguments,
}) async =>
    await Navigator.pushNamedAndRemoveUntil(
      context,
      newRouteName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
