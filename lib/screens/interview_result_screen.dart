import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'interview_setup_screen.dart';

class InterviewResultScreen extends StatelessWidget {
  const InterviewResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      ('Communication', 0.85, '85%'),
      ('Technical Depth', 0.72, '72%'),
      ('Confidence', 0.90, '90%'),
      ('Clarity', 0.78, '78%'),
    ];
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18))),
              const SizedBox(width: 14),
              Text('Interview Result', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Container(
                  width: double.infinity, padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(children: [
                    Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                      child: const Icon(Icons.emoji_events_rounded, color: AppColors.primary, size: 32)),
                    const SizedBox(height: 16),
                    Text('Interview Complete!', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Text('82', style: GoogleFonts.inter(fontSize: 48, fontWeight: FontWeight.w800, color: AppColors.primary)),
                    Text('Overall Score / 100', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                    const SizedBox(height: 16),
                    AppProgressBar(value: 0.82),
                  ]),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Performance Breakdown', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 14),
                    ...metrics.map((m) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Column(children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                          Text(m.$1, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary)),
                          Text(m.$3, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                        ]),
                        const SizedBox(height: 6),
                        AppProgressBar(value: m.$2),
                      ]),
                    )),
                  ]),
                ),
                const SizedBox(height: 20),
                InfoBox(
                  icon: Icons.star_outline_rounded,
                  text: 'Great job! Your communication skills are strong. Focus on improving technical depth with more practice.',
                  bg: AppColors.primaryLight, fg: AppColors.primary,
                ),
                const SizedBox(height: 24),
                PrimaryButton(label: 'Practice Again', icon: Icons.refresh_rounded,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InterviewSetupScreen()))),
                const SizedBox(height: 12),
                OutlineButton2(label: 'Back to Interview Home',
                  onTap: () => Navigator.of(context).popUntil((r) => r.isFirst)),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
