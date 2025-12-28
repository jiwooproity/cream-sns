import 'package:cream_sns/shared/toast/show_toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Widgets
import 'package:cream_sns/features/auth/widgets/auth_text_field.dart';
import 'package:cream_sns/shared/widgets/buttons/round_button.dart';

class SignupView extends ConsumerStatefulWidget {
  const SignupView({super.key});

  @override
  ConsumerState<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<SignupView> {
  final GlobalKey _globalKey = GlobalKey<FormState>();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _nickname = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _userId.dispose();
    _nickname.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  const Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthTextField(
                    textEditingController: _userId,
                    hintText: "사용자 아이디",
                  ),
                  const SizedBox(height: 5),
                  AuthTextField(
                    textEditingController: _nickname,
                    hintText: "닉네임",
                  ),
                  const SizedBox(height: 5),
                  AuthTextField(
                    textEditingController: _password,
                    hintText: "비밀번호",
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  RoundButton(btnText: "회원가입", onPressed: () => signUp()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void complete() {
    context.go("/login");
  }

  Future<void> signUp() async {
    final nickname = _nickname.text.trim();
    final userId = _userId.text.trim();
    final password = _password.text.trim();

    if (userId.isNotEmpty || nickname.isNotEmpty || password.isNotEmpty) {
      final provider = ref.read(authStateProvider.notifier);
      final message = await provider.signUp(userId, nickname, password);
      if(message != null && mounted) {
        ShowToast().init(context);
        ShowToast().show(message: message);
      } else {
        complete();
      }
    }
  }
}
