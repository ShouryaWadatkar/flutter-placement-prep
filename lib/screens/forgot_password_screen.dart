import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 36, height: 36,
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
              ),
            ),
            const SizedBox(height: 32),
            Center(child: Container(
              width: 72, height: 72,
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
              child: const Icon(Icons.lock_reset_rounded, color: AppColors.primary, size: 36),
            )),
            const SizedBox(height: 24),
            Center(child: Text('Forgot Password?', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary))),
            const SizedBox(height: 8),
            Center(child: Text("Enter your registered email and we'll send you a reset link.", textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.5))),
            const SizedBox(height: 32),
            const AppTextField(label: 'Email Address', hint: 'student@college.edu', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Send Reset Link',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Reset link sent!', style: GoogleFonts.inter()),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ));
                Navigator.pop(context);
              },
            ),
          ]),
        ),
      ),
    );
  }
}
