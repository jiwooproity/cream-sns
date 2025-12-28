import "package:flutter/material.dart";
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

final toastProvider = Provider.family<Toast, BuildContext>((ref, context) {
  final toast = Toast();
  toast.init(context);
  return toast;
});

abstract class ToastImpl {
  void show({required String message});
}

class Toast implements ToastImpl {
  static final FToast _fToast = FToast();

  void init(BuildContext context){
    _fToast.init(context);
  }

  @override
  void show({required String? message}) {
    if (message == null) return;

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
