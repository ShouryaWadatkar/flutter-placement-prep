import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'login_screen.dart';
import 'profile_setup_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
                ),
              ),
            ]),
            const SizedBox(height: 20),
            Center(child: const AppLogoIcon(size: 52)),
            const SizedBox(height: 20),
            Text('Create your account', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 6),
            Text('Start preparing for your placement journey.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 28),
            const AppTextField(label: 'Full Name', hint: 'Alex Johnson'),
            const SizedBox(height: 16),
            const AppTextField(label: 'Email Address', hint: 'alex@university.edu', keyboardType: TextInputType.emailAddress),
            const SizedBox(height: 16),
            const AppTextField(label: 'Password', hint: 'Create password (min. 8 characters)', obscure: true),
            const SizedBox(height: 16),
            const AppTextField(label: 'Confirm Password', hint: 'Re-enter password', obscure: true),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Create Account',
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileSetupScreen())),
            ),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Already have an account? ", style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
                child: Text('Log In', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
              ),
            ]),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
