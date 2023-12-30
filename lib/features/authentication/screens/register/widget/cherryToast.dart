import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:vitkart/utils/constants/colors.dart';

void showErrorToast(
  BuildContext context,
  String message, {
  double? width,
  String? title,
  bool? displayTitle,
  Color? titleColor,
  Color? messageColor,
  Position? position = Position.top,
  Duration? duration = const Duration(milliseconds: 1000),
  Color? backgroundColor,
  double? height,
  Cubic? animationCurve,
}) {
  CherryToast.error(
    title:
        Text(title ?? "", style: TextStyle(color: titleColor ?? Colors.black)),
    toastPosition: position ?? Position.top,
    width: width,
    displayTitle: displayTitle ?? false,
    description:
        Text(message, style: TextStyle(color: messageColor ?? Colors.black)),
    animationType: AnimationType.fromRight,
    animationDuration: duration!,
    autoDismiss: true,
    backgroundColor: backgroundColor ?? TColors.light,
    height: height,
    animationCurve: animationCurve ?? Curves.ease,
  ).show(context);
}
