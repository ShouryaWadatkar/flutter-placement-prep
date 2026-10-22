import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'test_setup_screen.dart';

class SkillGapScreen extends StatelessWidget {
  const SkillGapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final topics = [
      (Icons.bar_chart_rounded, 'Probability', '61% Accuracy', 'Needs Practice', AppColors.warning, AppColors.warningLight),
      (Icons.access_time_rounded, 'Time & Work', '64% Accuracy', 'Needs Practice', AppColors.warning, AppColors.warningLight),
      (Icons.extension_rounded, 'Logical Puzzles', '58% Accuracy', 'Priority', AppColors.error, AppColors.errorLight),
      (Icons.data_array_rounded, 'Arrays & Strings', '67% Accuracy', 'Improve', AppColors.primary, AppColors.primaryLight),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            GestureDetector(onTap: () => Navigator.pop(context),
              child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
            const SizedBox(height: 16),
            Text('Skill Gap', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('Focus on the areas that need more practice.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Your Skill Gap', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Text('Improving these topics can increase your placement readiness.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.4)),
                ])),
                const SizedBox(width: 12),
                PillChip(label: '4 areas need attention', bg: AppColors.warningLight, fg: AppColors.warning),
              ]),
            ),
            const SizedBox(height: 20),

            Text('TOPICS NEEDING IMPROVEMENT', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.1)),
            const SizedBox(height: 12),
            ...topics.map((t) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                child: Row(children: [
                  Container(width: 42, height: 42, decoration: BoxDecoration(color: t.$6, borderRadius: BorderRadius.circular(12)),
                    child: Icon(t.$1, color: t.$5, size: 20)),
                  const SizedBox(width: 14),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(t.$2, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Row(children: [
                      Text(t.$3, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                      const SizedBox(width: 8),
                      PillChip(label: t.$4, bg: t.$6, fg: t.$5),
                    ]),
                  ])),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestSetupScreen())),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      minimumSize: Size.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text('Practice', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600)),
                  ),
                ]),
              ),
            )),
            const SizedBox(height: 20),

            // Recommended next step
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight, borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primary.withAlpha(60)),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    const Icon(Icons.lightbulb_rounded, color: AppColors.primary, size: 16),
                    const SizedBox(width: 6),
                    Text('RECOMMENDED NEXT STEP', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.08)),
                  ]),
                  Text('Est. 15 mins', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ]),
                const SizedBox(height: 10),
                Text('Practice Logical Puzzles', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Start with 10 questions to improve your accuracy.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                const SizedBox(height: 14),
                PrimaryButton(label: 'Start Practice →', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TestSetupScreen()))),
              ]),
            ),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
