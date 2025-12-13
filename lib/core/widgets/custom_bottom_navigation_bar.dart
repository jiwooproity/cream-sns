import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Library
import 'package:go_router/go_router.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final GoRouterState state;

  const CustomBottomNavigationBar({super.key, required this.state});

  int _generateIndex(String location) {
    if (location.startsWith("/home")) return 0;
    if (location.startsWith("/search")) return 1;
    if (location.startsWith("/like")) return 2;
    return 3;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.grey, width: 0.5)),
      ),
      child: BottomNavigationBar(
        onTap: (index) {
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
        },
        currentIndex: _generateIndex(state.uri.path),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.black,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            label: "Like",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
