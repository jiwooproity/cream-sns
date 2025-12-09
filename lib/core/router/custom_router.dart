import 'package:cream_sns/core/widgets/custom_appbar.dart';
import 'package:cream_sns/core/widgets/custom_bottom_navigation_bar.dart';
import 'package:cream_sns/features/home/view/home_view.dart';
import 'package:cream_sns/features/like/view/like_view.dart';
import 'package:cream_sns/features/profile/view/profile_view.dart';
import 'package:cream_sns/features/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Paths {
  static const home = "/home";
  static const search = "/search";
  static const like = "/like";
  static const profile = "/profile";
}

class CustomRouter {
  static final router = GoRouter(
    initialLocation: Paths.home,
    routes: [
      ShellRoute(
        builder: (ctx, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavigationBar(state: state),
        ),
        routes: [
          ShellRoute(
            builder: (ctx, state, child) => Scaffold(
              appBar: CustomAppbar(title: "Cream"),
              body: child,
            ),
            routes: [
              GoRoute(
                path: Paths.home,
                builder: (ctx, state) => const HomeView(),
              ),
              GoRoute(
                path: Paths.search,
                builder: (ctx, state) => const SearchView(),
              ),
              GoRoute(
                path: Paths.like,
                builder: (ctx, state) => const LikeView(),
              ),
            ],
          ),
          GoRoute(
            path: Paths.profile,
            builder: (ctx, state) => const ProfileView(),
          ),
        ],
      ),
    ],
  );
}
