import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/features/auth/widgets/auth_text_field.dart';
import 'package:cream_sns/shared/widgets/round_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _emailTextEditController =
      TextEditingController();
  final TextEditingController _passwordTextEditController =
      TextEditingController();

  @override
  void dispose() {
    _emailTextEditController.dispose();
    _passwordTextEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Cream",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                AuthTextField(
                  textEditingController: _emailTextEditController,
                  hintText: "사용자 아이디",
                ),
                SizedBox(height: 5),
                AuthTextField(
                  textEditingController: _passwordTextEditController,
                  hintText: "비밀번호",
                ),
                SizedBox(height: 15),
                RoundButton(btnText: "로그인", onPressed: () {}),
                SizedBox(height: 15),
                Row(
                  spacing: 5,
                  children: [
                    const Text("아직 계정이 없으신가요?"),
                    GestureDetector(
                      onTap: () {
                        context.push("/signup");
                      },
                      child: const Text(
                        "회원가입",
                        style: TextStyle(
                          color: AppColors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
