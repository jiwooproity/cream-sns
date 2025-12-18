import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Library
import 'package:go_router/go_router.dart';

// Widgets
import 'package:cream_sns/shared/widgets/divider/custom_divider.dart';

class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  final GoRouterState state;

  const CustomBottomNavigationBar({super.key, required this.state});

  @override
  ConsumerState<CustomBottomNavigationBar> createState() {
    return _CustomBottomNavigationBarState();
  }
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar> {
  int currentIndex = 0;

  void onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go("/home");
      case 1:
        context.go("/search");
      case 2:
        context.go("/like");
      case 3:
        context.go("/profile");
    }

    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const CustomDivider(),
        BottomAppBar(
          height: 56,
          padding: EdgeInsets.zero,
          color: AppColors.white,
          elevation: 0,
          child: Row(
            children: [
              _NavItem(
                index: 0,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                index: 1,
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                index: 2,
                icon: Icons.favorite_outline,
                activeIcon: Icons.favorite,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
              _NavItem(
                index: 3,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                currentIndex: currentIndex,
                onTap: onTap,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final void Function(BuildContext, int) onTap;

  const _NavItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;
    final Color color = isActive ? AppColors.black : AppColors.black;

    return Expanded(
      child: InkWell(
        onTap: () => onTap(context, index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          child: AnimatedScale(
            scale: isActive ? 1.15 : 1.0,
            duration: const Duration(milliseconds: 1000),
            curve: Curves.elasticOut,
            child: Icon(isActive ? activeIcon : icon, size: 25, color: color),
          ),
        ),
      ),
    );
  }
}
