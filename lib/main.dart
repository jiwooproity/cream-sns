import 'package:flutter/material.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Router
import 'package:cream_sns/core/router/custom_router.dart';

void main() {
  runApp(const MyApp());
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
