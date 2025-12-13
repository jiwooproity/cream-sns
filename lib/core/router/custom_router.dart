import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// Library
import 'package:go_router/go_router.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_bottom_navigation_bar.dart';

// Views
import 'package:cream_sns/features/home/view/home_view.dart';
import 'package:cream_sns/features/post/views/create_post.dart';
import 'package:cream_sns/features/like/view/like_view.dart';
import 'package:cream_sns/features/profile/views/profile_view.dart';
import 'package:cream_sns/features/profile/views/profile_edit_view.dart';
import 'package:cream_sns/features/search/search_view.dart';
import 'package:cream_sns/features/auth/view/login_view.dart';
import 'package:cream_sns/features/auth/view/signup_view.dart';

class Paths {
  static const home = "/home";
  static const createPost = "/post/create";
  static const search = "/search";
  static const like = "/like";
  static const profile = "/profile";
  static const editProfile = "/profile/edit";
  static const login = "/login";
  static const signup = "/signup";
}

class CustomRouter {
  static final router = GoRouter(
    initialLocation: Paths.login,
    routes: [
      ShellRoute(
        builder: (ctx, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavigationBar(state: state),
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
          GoRoute(
            path: Paths.profile,
            builder: (ctx, state) => const ProfileView(),
          ),
        ],
      ),
      GoRoute(path: Paths.login, builder: (ctx, state) => const LoginView()),
      GoRoute(path: Paths.signup, builder: (ctx, state) => const SignupView()),
      GoRoute(
        path: Paths.createPost,
        builder: (ctx, state) => CreatePost(image: state.extra as XFile),
      ),
      GoRoute(
        path: Paths.editProfile,
        builder: (ctx, state) => const ProfileEditView(),
      ),
    ],
  );
}
