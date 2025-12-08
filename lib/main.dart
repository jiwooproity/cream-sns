import 'package:cream_sns/navigation/custom_appbar.dart';
import 'package:cream_sns/theme/colors.dart';
import 'package:flutter/material.dart';

// Libraries
import 'package:go_router/go_router.dart';

// Views
import 'package:cream_sns/views/home/home_view.dart';
import 'package:cream_sns/views/search/search_view.dart';
import 'package:cream_sns/views/like/like_view.dart';
import 'package:cream_sns/views/profile/profile_view.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: "/home",
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: CustomAppbar(title: 'Cream'),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.white,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Search"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Like"),
              BottomNavigationBarItem(icon: Icon(Icons.add), label: "Profile"),
            ],
          ),
        );
      },
      routes: [
        GoRoute(path: "/home", builder: (context, state) => const HomeView()),
        GoRoute(
          path: "/search",
          builder: (context, state) => const SearchView(),
        ),
        GoRoute(path: "/like", builder: (context, state) => const LikeView()),
        GoRoute(
          path: "/profile",
          builder: (context, state) => const ProfileView(),
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Cream SNS",
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}
