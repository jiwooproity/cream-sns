import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CustomModal extends StatelessWidget {
  final bool isAction;
  final IconData? icon;

  final List<Widget> widgets;

  const CustomModal({
    super.key,
    this.isAction = true,
    this.icon,
    required this.widgets,
  });

  @override
  Widget build(BuildContext context) {
    return isAction
        ? GestureDetector(
            child: Icon(icon),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => modalList(widgets),
              );
            },
          )
        : modalList(widgets);
  }

  Widget modalList(List<Widget> widgets) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: AppColors.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: widgets.map((widget) => widget).toList(),
      ),
    );
  }
}
