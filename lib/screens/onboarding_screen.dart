import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 24),
            // Logo row
            Row(children: [
              const AppLogoIcon(size: 36),
              const SizedBox(width: 10),
              Text('Placement Prep', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
            const SizedBox(height: 32),
            // Headline
            Text('Your placement journey starts here.',
                style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: AppColors.textPrimary, height: 1.2)),
            const SizedBox(height: 12),
            Text('Practice aptitude, improve coding skills, prepare for interviews, and track your progress — all in one place.',
                style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary, height: 1.6)),
            const SizedBox(height: 32),
            // Feature cards
            _FeatureTile(
              icon: Icons.code_rounded,
              title: 'Practice Tests',
              desc: 'Comprehensive aptitude and technical mock assessments.',
            ),
            const SizedBox(height: 12),
            _FeatureTile(
              icon: Icons.chat_bubble_outline_rounded,
              title: 'Interview Preparation',
              desc: 'Curated HR and tech interview question banks.',
            ),
            const SizedBox(height: 12),
            _FeatureTile(
              icon: Icons.trending_up_rounded,
              title: 'Progress Tracking',
              desc: 'Real-time performance analytics and readiness scores.',
            ),
            const SizedBox(height: 32),
            PrimaryButton(
              label: 'Get Started',
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
            ),
            const SizedBox(height: 16),
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

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  const _FeatureTile({required this.icon, required this.title, required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: 44, height: 44,
          decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          Text(desc, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
        ])),
      ]),
    );
  }
}
