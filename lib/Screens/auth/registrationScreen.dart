import 'package:flutter/material.dart';
import 'package:follower_for_tik_likes_views/core/router/app_routes.dart';
import 'package:follower_for_tik_likes_views/provider/auth_provider.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/custom_textfeild.dart';
import 'package:follower_for_tik_likes_views/shared/widgets/socialButton.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/validators.dart';
import '../../shared/widgets/custom_button.dart';
import 'auth_widgets.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    // Persist registered user through AuthProvider
    await context.read<AuthProvider>().register(
          _nameCtrl.text.trim(),
          _emailCtrl.text.trim(),
          _passCtrl.text,
        );

    if (!mounted) return;
    setState(() => _loading = false);
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.main, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back arrow + TrendSpark
                Row(
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      borderRadius: BorderRadius.circular(20),
                      child: const Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(Icons.arrow_back_ios_new_rounded,
                            size: 20, color: AppColors.primaryDark),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Trend',
                            style: TextStyle(color: AppColors.primaryDark),
                          ),
                          TextSpan(
                            text: 'Spark',
                            style: TextStyle(color: AppColors.accent),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text('Create Your Account', style: textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text('Join us and start growing today',
                    style: textTheme.bodyMedium),
                const SizedBox(height: 24),
                CustomTextField(
                  hint: 'Full Name',
                  prefixIcon: Icons.person_rounded,
                  controller: _nameCtrl,
                  validator: Validators.name,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hint: 'Email or Username',
                  prefixIcon: Icons.mail_rounded,
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.emailOrUsername,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  hint: 'Password',
                  prefixIcon: Icons.lock_rounded,
                  controller: _passCtrl,
                  isPassword: true,
                  textInputAction: TextInputAction.done,
                  validator: Validators.password,
                ),
                const SizedBox(height: 22),
                CustomButton(
                  text: 'Sign Up',
                  isLoading: _loading,
                  onPressed: _register,
                ),
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
                      Text('Already have an account?  ',
                          style: textTheme.bodyMedium
                              ?.copyWith(color: textTheme.bodyLarge?.color)),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Login',
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
