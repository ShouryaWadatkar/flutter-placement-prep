import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';

class CodingResultScreen extends StatelessWidget {
  final String type;
  final int correct, total;
  const CodingResultScreen({
    super.key,
    this.type = 'Coding',
    int? correct,
    int? score,
    required this.total,
  }) : correct = correct ?? score ?? 0;

  @override
  Widget build(BuildContext context) {
    final wrong = total - correct;
    final pct = (correct / total * 100).round();
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
              Text('Quiz Result', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(children: [
                    Container(width: 64, height: 64, decoration: BoxDecoration(color: AppColors.primaryLight, shape: BoxShape.circle),
                      child: const Icon(Icons.emoji_events_rounded, color: AppColors.primary, size: 32)),
                    const SizedBox(height: 16),
                    PillChip(label: type.toUpperCase()),
                    const SizedBox(height: 10),
                    Text('$correct / $total', style: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                    Text('$pct% Score', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primary)),
                    const SizedBox(height: 16),
                    AppProgressBar(value: correct / total),
                    const SizedBox(height: 16),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      Column(children: [Text('$correct', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.success)), Text('Correct', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary))]),
                      Container(width: 1, height: 36, color: AppColors.border),
                      Column(children: [Text('$wrong', style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.error)), Text('Wrong', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary))]),
                    ]),
                  ]),
                ),
                const SizedBox(height: 24),
                PrimaryButton(label: 'Practice Again', icon: Icons.refresh_rounded,
                  onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CodingResultScreen(type: type, correct: correct, total: total)))),
                const SizedBox(height: 12),
                OutlineButton2(label: 'Back to Coding Home', onTap: () => Navigator.pop(context)),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
