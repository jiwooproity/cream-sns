import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Providers
import 'package:cream_sns/features/auth/provider/auth_provider.dart';

// Themes
import 'package:cream_sns/core/theme/app_colors.dart';

// Widgets
import 'package:cream_sns/features/auth/widgets/auth_text_field.dart';
import 'package:cream_sns/shared/widgets/buttons/round_button.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _userId.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    await ref.read(authStateProvider.notifier).me();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(authStateProvider);

    ref.listen(authStateProvider, (prev, cur) async {
      if (!prev!.isAuthenticated && cur.isAuthenticated) {
        context.go("/home");
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _loginFormKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Cream",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  AuthTextField(
                    textEditingController: _userId,
                    hintText: "사용자 아이디",
                  ),
                  SizedBox(height: 5),
                  AuthTextField(
                    textEditingController: _password,
                    hintText: "비밀번호",
                  ),
                  SizedBox(height: 15),
                  RoundButton(
                    btnText: "로그인",
                    onPressed: () => _handleLogin(ref),
                  ),
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
      ),
    );
  }

  void _handleLogin(WidgetRef ref) {
    final userId = _userId.text;
    final password = _password.text;

    if (userId.isEmpty || password.isEmpty) {
      return;
    }

    ref.read(authStateProvider.notifier).login(userId, password);
  }
}
