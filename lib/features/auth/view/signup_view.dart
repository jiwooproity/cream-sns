import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Widgets
import 'package:cream_sns/features/auth/widgets/auth_text_field.dart';
import 'package:cream_sns/shared/widgets/round_button.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _idTextEditController = TextEditingController();
  final TextEditingController _nickNameTextEditController =
      TextEditingController();
  final TextEditingController _passwordTextEditController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                AuthTextField(
                  textEditingController: _idTextEditController,
                  hintText: "사용자 아이디",
                ),
                SizedBox(height: 5),
                AuthTextField(
                  textEditingController: _nickNameTextEditController,
                  hintText: "닉네임",
                ),
                SizedBox(height: 5),
                AuthTextField(
                  textEditingController: _passwordTextEditController,
                  hintText: "비밀번호",
                ),
                SizedBox(height: 15),
                RoundButton(
                  btnText: "회원가입",
                  onPressed: () {
                    context.go("/login");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
