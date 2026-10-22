import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'interview_setup_screen.dart';
import 'interview_history_screen.dart';

class InterviewHomeScreen extends StatelessWidget {
  const InterviewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('Interview Preparation', style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
              CircleAvatar(radius: 20, backgroundColor: AppColors.primaryLight,
                child: const Icon(Icons.person_rounded, color: AppColors.primary, size: 22)),
            ]),
            const SizedBox(height: 4),
            Text('Practice before your next interview.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 20),

            // Hero card
            Container(
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Container(
                    height: 150, width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [AppColors.primary.withAlpha(160), AppColors.primaryDark], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    ),
                    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Icon(Icons.videocam_rounded, color: Colors.white, size: 48),
                      const SizedBox(height: 8),
                      Text('AI Voice Interview', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Be interview ready', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('Practice common interview questions and improve your confidence.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                  ]),
                ),
              ]),
            ),
            const SizedBox(height: 24),

            SectionHeader(title: 'Categories', actionLabel: 'View All', onAction: () {}),
            const SizedBox(height: 14),
            CategoryCard(
              icon: Icons.work_outline_rounded, title: 'HR Interview',
              subtitle: 'Practice common HR questions.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewSetupScreen())),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.code_rounded, title: 'Technical Interview',
              subtitle: 'Prepare technical interview questions.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewSetupScreen())),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.psychology_outlined, title: 'Behavioral Interview',
              subtitle: 'Practice questions about your experience and approach.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewSetupScreen())),
            ),
            const SizedBox(height: 24),

            Text('Recent Interview Practice', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text('Technical Interview', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(width: 8),
                    Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: AppColors.surfaceVariant, borderRadius: BorderRadius.circular(20)),
                      child: Text('Completed', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.textSecondary))),
                  ]),
                  const SizedBox(height: 4),
                  Text('Yesterday', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                ])),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewHistoryScreen())),
                  child: Container(width: 34, height: 34, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                    child: const Icon(Icons.refresh_rounded, color: AppColors.primary, size: 18)),
                ),
              ]),
            ),
            const SizedBox(height: 20),
            PrimaryButton(
              label: '▷  Start Interview Practice',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewSetupScreen())),
            ),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
