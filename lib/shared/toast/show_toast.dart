import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class ShowToast {
  ShowToast._internal();

  static final ShowToast _instance = ShowToast._internal();

  factory ShowToast() => _instance;

  final FToast _fToast = FToast();

  void init(BuildContext context) {
    _fToast.init(context);
  }

  void show({
    required String message,
    Duration duration = const Duration(seconds: 2),
  }) {
    Widget toast = Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.black,
      ),
      child: Text(message, style: const TextStyle(color: AppColors.white)),
    );

    _fToast.showToast(child: toast, gravity: ToastGravity.BOTTOM);
  }
}
