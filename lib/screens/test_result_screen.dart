import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'test_setup_screen.dart';

class TestResultScreen extends StatelessWidget {
  final int total;
  final int correct;
  final int timeTaken;

  const TestResultScreen({super.key, required this.total, required this.correct, required this.timeTaken});

  @override
  Widget build(BuildContext context) {
    final wrong = total - correct - 1;
    final unanswered = 1;
    final accuracy = (correct / total * 100).round();
    final m = (timeTaken ~/ 60).toString().padLeft(2, '0');
    final s = (timeTaken % 60).toString().padLeft(2, '0');
    final timeStr = '$m:$s';

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary)),
              ),
              const SizedBox(width: 14),
              Text('Test Result', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                // Score card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      PillChip(label: 'QUANTITATIVE APTITUDE'),
                      Text('Standard Test', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    ]),
                    const SizedBox(height: 12),
                    Text('Test Completed!', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 8),
                    Row(crossAxisAlignment: CrossAxisAlignment.baseline, textBaseline: TextBaseline.alphabetic, children: [
                      Text('$correct / $total', style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                      const SizedBox(width: 10),
                      Text('$accuracy% Accuracy', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    ]),
                    const SizedBox(height: 6),
                    Text('You successfully answered $correct questions correctly.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    const SizedBox(height: 12),
                    AppProgressBar(value: correct / total),
                  ]),
                ),
                const SizedBox(height: 16),

                // Stats row
                Row(children: [
                  _StatBox(label: 'Correct', value: '$correct', color: AppColors.success),
                  const SizedBox(width: 10),
                  _StatBox(label: 'Wrong', value: '${wrong.clamp(0, 99)}', color: AppColors.error),
                  const SizedBox(width: 10),
                  _StatBox(label: 'Unanswered', value: '$unanswered', color: AppColors.textSecondary),
                ]),
                const SizedBox(height: 16),

                // Time taken
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(children: [
                      Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.timer_outlined, color: AppColors.primary, size: 18)),
                      const SizedBox(width: 12),
                      Text('Time Taken', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                    ]),
                    Text(timeStr, style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                  ]),
                ),
                const SizedBox(height: 16),

                // Feedback card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(16),
                    border: const Border(left: BorderSide(color: AppColors.primary, width: 3)),
                  ),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Icon(Icons.emoji_events_outlined, color: AppColors.primary, size: 20),
                    const SizedBox(width: 10),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Good job!', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      const SizedBox(height: 4),
                      Text('Your fundamentals are strong. Keep practicing to improve your speed and accuracy.',
                          style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
                    ])),
                  ]),
                ),
                const SizedBox(height: 24),

                PrimaryButton(label: 'Review Answers →', onTap: () {}),
                const SizedBox(height: 12),
                OutlineButton2(
                  label: 'Try Again',
                  icon: Icons.refresh_rounded,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const TestSetupScreen())),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                  child: Text('Back to Tests', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value;
  final Color color;
  const _StatBox({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
        child: Column(children: [
          Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: color)),
        ]),
      ),
    );
  }
}
