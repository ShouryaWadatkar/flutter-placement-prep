import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'signup_screen.dart';
import 'forgot_password_screen.dart';
import 'main_shell.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
                ),
              ),
              Text('PORTAL ACCESS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 0.1, color: AppColors.textMuted)),
            ]),
            const SizedBox(height: 32),
            Center(child: const AppLogoIcon(size: 52)),
            const SizedBox(height: 20),
            Center(child: Text('Welcome Back!', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary))),
            const SizedBox(height: 6),
            Center(child: Text('Continue your placement preparation.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary))),
            const SizedBox(height: 32),
            const AppTextField(label: 'Email Address', hint: 'student@college.edu', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            const AppTextField(label: 'Password', hint: 'Enter your password', obscure: true),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                child: Text('Forgot Password?', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
              ),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: 'Log In',
              onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainShell()), (_) => false),
            ),
            const SizedBox(height: 20),
            Row(children: [
              const Expanded(child: Divider(color: AppColors.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Text('OR', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted, fontWeight: FontWeight.w500)),
              ),
              const Expanded(child: Divider(color: AppColors.border)),
            ]),
            const SizedBox(height: 20),
            _GoogleButton(onTap: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const MainShell()), (_) => false)),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Don't have an account? ", style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                child: Text('Sign Up', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
            ]),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}

class _GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GoogleButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity, height: 52,
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          // Google G icon
          Container(
            width: 22, height: 22,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: const Icon(Icons.g_mobiledata_rounded, size: 26, color: Color(0xFF4285F4)),
          ),
          const SizedBox(width: 10),
          Text('Continue with Google', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        ]),
      ),
    );
  }
}
