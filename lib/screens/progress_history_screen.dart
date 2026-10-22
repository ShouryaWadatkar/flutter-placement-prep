import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'skill_gap_screen.dart';

class ProgressHistoryScreen extends StatelessWidget {
  const ProgressHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      ('Quantitative Aptitude Test', 'Today', '16 / 20', 0.80),
      ('Logical Reasoning Test', 'Yesterday', '18 / 20', 0.90),
      ('Technical Test', '2 days ago', '14 / 20', 0.70),
      ('Verbal Ability Test', '3 days ago', '17 / 20', 0.85),
      ('Output Prediction', '4 days ago', '8 / 10', 0.80),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Progress & History'),
        leading: GestureDetector(onTap: () => Navigator.pop(context),
          child: Container(margin: const EdgeInsets.all(8), decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 8),
          // Stats summary
          Row(children: [
            _StatCard(label: 'Tests Done', value: '24', icon: Icons.quiz_outlined),
            const SizedBox(width: 10),
            _StatCard(label: 'Avg Score', value: '82%', icon: Icons.trending_up_rounded),
            const SizedBox(width: 10),
            _StatCard(label: 'Streak', value: '7d', icon: Icons.local_fire_department_rounded),
          ]),
          const SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Skill Gap Analysis', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SkillGapScreen())),
              child: Text('View →', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primary)),
            ),
          ]),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SkillGapScreen())),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.primary.withAlpha(60))),
              child: Row(children: [
                const Icon(Icons.insights_rounded, color: AppColors.primary, size: 24),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('4 areas need attention', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                  Text('Tap to see your skill gap analysis', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ])),
                const Icon(Icons.chevron_right_rounded, color: AppColors.primary, size: 20),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          Text('Test History', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 14),
          ...history.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Expanded(child: Text(h.$1, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(h.$3, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary))),
                ]),
                const SizedBox(height: 4),
                Text(h.$2, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                const SizedBox(height: 8),
                AppProgressBar(value: h.$4),
              ]),
            ),
          )),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _StatCard({required this.label, required this.value, required this.icon});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(height: 6),
        Text(value, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary, height: 1.3), textAlign: TextAlign.center),
      ]),
    ),
  );
}
