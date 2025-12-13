import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

class TabsBar extends StatelessWidget {
  const TabsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      labelColor: AppColors.black,
      indicatorColor: AppColors.black,
      tabs: [
        Tab(icon: Icon(Icons.grid_on_outlined)),
        Tab(icon: Icon(Icons.favorite_outline)),
      ],
    );
  }
}
