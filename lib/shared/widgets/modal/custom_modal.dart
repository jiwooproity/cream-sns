import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class CustomModal extends StatelessWidget {
  final bool isAction;
  final IconData? icon;
  final Widget? child;

  final List<Widget> children;

  const CustomModal({
    super.key,
    this.isAction = true,
    this.icon,
    this.child,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return isAction
        ? GestureDetector(
            child: Icon(icon),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => modalList(children),
                backgroundColor: Colors.transparent, // 중요
              );
            },
          )
        : GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => modalList(children),
                backgroundColor: Colors.transparent, // 중요
              );
            },
            child: child,
          );
  }

  Widget modalList(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(width: 5, color: AppColors.grey),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: AppColors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              offset: Offset(2, 4),
              blurRadius: 50
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: widgets.map((widget) => widget).toList(),
        ),
      ),
    );
  }
}
