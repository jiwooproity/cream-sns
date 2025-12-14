import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:timeago/timeago.dart' as time_ago;

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Router
import 'package:cream_sns/core/router/custom_router.dart';

void main() {
  time_ago.setLocaleMessages('ko', time_ago.KoMessages());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Cream",
      theme: ThemeData(scaffoldBackgroundColor: AppColors.white),
      debugShowCheckedModeBanner: false,
      routerConfig: CustomRouter.router,
    );
  }
}
