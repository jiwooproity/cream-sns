import 'dart:typed_data';

import 'package:cream_sns/features/post/views/edit_post.dart';
import 'package:flutter/material.dart';

// Models
import 'package:cream_sns/features/post/models/post.dart' hide PostDetail;
import 'package:cream_sns/features/profile/model/profile.dart';
import 'package:cream_sns/features/crop/model/crop_param.dart';

// Library
import 'package:go_router/go_router.dart';

// Widgets
import 'package:cream_sns/core/widgets/custom_bottom_navigation_bar.dart';

// Views
import 'package:cream_sns/features/home/view/home_view.dart';
import 'package:cream_sns/features/post/views/create_post.dart';
import 'package:cream_sns/features/post/views/post_detail.dart';
import 'package:cream_sns/features/like/view/like_view.dart';
import 'package:cream_sns/features/profile/views/profile_view.dart';
import 'package:cream_sns/features/profile/views/profile_edit_view.dart';
import 'package:cream_sns/features/search/views/search_view.dart';
import 'package:cream_sns/features/auth/view/login_view.dart';
import 'package:cream_sns/features/auth/view/signup_view.dart';
import 'package:cream_sns/features/crop/views/crop_view.dart';

class Paths {
  static const home = "/home";
  static const createPost = "/post/create";
  static const editPost = "/post/edit";
  static const postDetail = "/post/detail";
  static const search = "/search";
  static const like = "/like";
  static const profile = "/profile";
  static const profileWithId = "/profile/:id";
  static const editProfile = "/profile/edit";
  static const login = "/login";
  static const signup = "/signup";
  static const cropImage = "/image/crop";
}

class CustomRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: Paths.login,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (ctx, state, child) => Scaffold(
          body: child,
          bottomNavigationBar: CustomBottomNavigationBar(state: state),
        ),
        routes: [
          GoRoute(path: Paths.home, builder: (ctx, state) => const HomeView()),
          GoRoute(
            path: Paths.search,
            builder: (ctx, state) => const SearchView(),
          ),
          GoRoute(path: Paths.like, builder: (ctx, state) => const LikeView()),
          GoRoute(
            path: Paths.profile,
            builder: (ctx, state) => const ProfileView(),
          ),
        ],
      ),
      GoRoute(path: Paths.login, builder: (ctx, state) => const LoginView()),
      GoRoute(path: Paths.signup, builder: (ctx, state) => const SignupView()),
      GoRoute(
        path: Paths.editProfile,
        builder: (ctx, state) {
          return ProfileEditView(user: state.extra as Profile);
        },
      ),
      GoRoute(
        path: Paths.profileWithId,
        builder: (ctx, state) {
          return ProfileView(targetId: state.pathParameters['id']);
        },
      ),
      GoRoute(
        path: Paths.createPost,
        builder: (ctx, state) => CreatePost(image: state.extra as Uint8List),
      ),
      GoRoute(
        path: Paths.editPost,
        builder: (ctx, state) => EditPost(post: state.extra as Post),
      ),
      GoRoute(
        path: Paths.postDetail,
        builder: (ctx, state) => PostDetail(postId: state.extra as String),
      ),
      GoRoute(
        path: Paths.cropImage,
        builder: (ctx, state) {
          final params = state.extra as CropParam;
          return CropView(
            image: params.image,
            aspectRatio: params.aspectRatio,
            goBack: params.goBack,
            path: params.path,
          );
        },
      ),
    ],
  );
}
