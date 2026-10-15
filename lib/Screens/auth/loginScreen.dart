import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_textfeild.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/socialButton.dart';
import '../../core/constants/app_colors.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import '../../core/utils/validators.dart';
import '../../shared/widgets/custom_button.dart';
import 'auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    debugPrint('1. login pressed');

    if (!_formKey.currentState!.validate()) {
      debugPrint('2. validation failed');
      return;
    }

    setState(() => _loading = true);
    debugPrint('3. validation passed, loading shuru');

    // TODO: AuthProvider.login() se replace karein.
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) {
      debugPrint('4. screen mounted nahi hai');
      return;
    }
    setState(() => _loading = false);

    debugPrint('5. ab Home par ja rahe hain');
    Navigator.pushReplacementNamed(context, AppRoutes.main);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const Center(child: AuthBrandHeader()),
                const SizedBox(height: 28),
                Text('Welcome Back!', style: textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text('Login to continue', style: textTheme.bodyMedium),
                const SizedBox(height: 24),
                CustomTextField(
                  hint: 'Email or Username',
                  prefixIcon: Icons.mail_outline_rounded,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailOrUsername,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hint: 'Password',
                  prefixIcon: Icons.lock_outline_rounded,
                  controller: _passCtrl,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: Validators.password,
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {}, // TODO: forgot password
                    child: Text(
                      'Forgot Password?',
                      style: textTheme.bodySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                CustomButton(
                    text: 'Login', isLoading: _loading, onPressed: _login),
                const SizedBox(height: 18),
                const AuthOrDivider(),
                const SizedBox(height: 18),
                SocialButton.google(onPressed: () {}),
                const SizedBox(height: 14),
                SocialButton.apple(onPressed: () {}),
                const SizedBox(height: 28),
                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Don't have an account?  ",
                          style: textTheme.bodyMedium
                              ?.copyWith(color: textTheme.bodyLarge?.color)),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoutes.register),
                        child: Text(
                          'Sign Up',
                          style: textTheme.bodyMedium?.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}