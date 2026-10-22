import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'performance_analytics_screen.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      ('Quantitative Aptitude', 0.82, '82%'),
      ('Logical Reasoning', 0.76, '76%'),
      ('Verbal Ability', 0.88, '88%'),
      ('Technical', 0.71, '71%'),
    ];
    final recent = [
      ('Quantitative Aptitude Test', 'Today', '16 / 20'),
      ('Logical Reasoning Test', 'Yesterday', '18 / 20'),
      ('Technical Test', '2 days ago', '14 / 20'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Reports', style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                Text('Track your preparation progress.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.surface, shape: BoxShape.circle, border: Border.all(color: AppColors.border)),
                child: const Icon(Icons.person_rounded, color: AppColors.textSecondary, size: 22)),
            ]),
            const SizedBox(height: 20),

            // Readiness card
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const PerformanceAnalyticsScreen())),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Placement Readiness', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    Text('72%', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.primary)),
                  ]),
                  const SizedBox(height: 4),
                  Text("You're on the right track.", style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                  const SizedBox(height: 10),
                  const AppProgressBar(value: 0.72),
                  const SizedBox(height: 8),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('12 of 16 skills covered', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                    PillChip(label: 'On Target', bg: AppColors.successLight, fg: AppColors.success),
                  ]),
                ]),
              ),
            ),
            const SizedBox(height: 24),

            Text('Overall Performance', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 14),
            Row(children: [
              _PerfBox(label: 'Tests\nCompleted', value: '24'),
              const SizedBox(width: 10),
              _PerfBox(label: 'Questions\nSolved', value: '480'),
              const SizedBox(width: 10),
              _PerfBox(label: 'Overall\nAccuracy', value: '82%', color: AppColors.primary),
            ]),
            const SizedBox(height: 24),

            Text('Subject Performance', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 14),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Column(children: subjects.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: Column(children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text(s.$1, style: GoogleFonts.inter(fontSize: 14, color: AppColors.textPrimary)),
                    Text(s.$3, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ]),
                  const SizedBox(height: 6),
                  AppProgressBar(value: s.$2),
                ]),
              )).toList()),
            ),
            const SizedBox(height: 24),

            Text('Recent Activity', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 14),
            ...recent.map((r) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(r.$1, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    Text(r.$2, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                  ]),
                  Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(r.$3, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary))),
                ]),
              ),
            )),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}

class _PerfBox extends StatelessWidget {
  final String label, value;
  final Color? color;
  const _PerfBox({required this.label, required this.value, this.color});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Column(children: [
        Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: color ?? AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(label, textAlign: TextAlign.center, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary, height: 1.4)),
      ]),
    ),
  );
}
