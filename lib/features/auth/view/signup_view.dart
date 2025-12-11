import 'package:cream_sns/features/auth/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Widgets
import 'package:cream_sns/features/auth/widgets/auth_text_field.dart';
import 'package:cream_sns/shared/widgets/round_button.dart';

class SignupView extends ConsumerWidget {
  final GlobalKey _globalKey = GlobalKey<FormState>();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _password = TextEditingController();

  SignupView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _globalKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  AuthTextField(
                    textEditingController: _userId,
                    hintText: "사용자 아이디",
                  ),
                  SizedBox(height: 5),
                  AuthTextField(
                    textEditingController: _nickname,
                    hintText: "닉네임",
                  ),
                  SizedBox(height: 5),
                  AuthTextField(
                    textEditingController: _password,
                    hintText: "비밀번호",
                    obscureText: true,
                  ),
                  SizedBox(height: 15),
                  RoundButton(
                    btnText: "회원가입",
                    onPressed: () async {
                      final userId = _userId.text;
                      final nickname = _nickname.text;
                      final password = _password.text;

                      if(userId.isEmpty || nickname.isEmpty || password.isEmpty) {
                        return;
                      }

                      final response = await ref
                          .read(authStateProvider.notifier)
                          .signUp(userId, nickname, password);

                      if (context.mounted) {
                        if (response == null) {
                          context.go("/login");
                        } else {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(response)));
                        }
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
