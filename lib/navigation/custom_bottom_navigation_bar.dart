import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/theme/colors.dart';

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
    return BottomNavigationBar(
      onTap: (index) {
        switch(index) {
          case 0: context.go("/home");
          case 1: context.go("/search");
          case 2: context.go("/like");
          case 3: context.go("/profile");
        }
      },
      currentIndex: _generateIndex(state.uri.path),
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.blue,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Home"),
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
    );
  }
}
