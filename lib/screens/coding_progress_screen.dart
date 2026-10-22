import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';

class CodingProgressScreen extends StatelessWidget {
  const CodingProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = [
      ('Output Prediction', '8 / 10', 'Today', '80%'),
      ('Debugging', '7 / 10', 'Yesterday', '70%'),
      ('Complete the Code', '9 / 10', '2 days ago', '90%'),
      ('Arrange the Code', '6 / 10', '3 days ago', '60%'),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Progress & History'),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
            child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary)),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _StatCol(label: 'Quizzes Done', value: '24'),
                Container(width: 1, height: 36, color: AppColors.border),
                _StatCol(label: 'Avg Score', value: '75%'),
                Container(width: 1, height: 36, color: AppColors.border),
                _StatCol(label: 'Best Score', value: '90%'),
              ]),
            ]),
          ),
          const SizedBox(height: 24),
          Text('Recent Sessions', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: 14),
          ...history.map((h) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
              child: Row(children: [
                Container(width: 42, height: 42, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.code_rounded, color: AppColors.primary, size: 20)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(h.$1, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                  Text(h.$3, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                ])),
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                  Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                    child: Text(h.$2, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary))),
                  const SizedBox(height: 2),
                  Text(h.$4, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ]),
              ]),
            ),
          )),
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}

class _StatCol extends StatelessWidget {
  final String label, value;
  const _StatCol({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
    const SizedBox(height: 2),
    Text(label, style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
  ]);
}
