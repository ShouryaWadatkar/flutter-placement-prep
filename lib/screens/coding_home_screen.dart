import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'coding_progress_screen.dart';
import 'coding_practice_setup_screen.dart';

class CodingHomeScreen extends StatelessWidget {
  const CodingHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary)),
              ),
            ]),
            const SizedBox(height: 16),
            Text('Coding Practice', style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
            const SizedBox(height: 4),
            Text('Build coding logic, one question at a time', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
            const SizedBox(height: 20),

            // Banner card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                PillChip(label: 'CODING PRACTICE'),
                const SizedBox(height: 10),
                Text('Practice coding without a compiler', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 4),
                Text('Improve your programming logic with short, mobile-friendly coding questions.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.5)),
              ]),
            ),
            const SizedBox(height: 24),

            Text('Choose how you want to practice', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 14),

            CategoryCard(
              icon: Icons.terminal_rounded, title: 'Output Prediction',
              subtitle: 'Predict what the code will print.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodingPracticeSetupScreen(initialMode: 'Output Prediction'))),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.bug_report_outlined, title: 'Debugging',
              subtitle: 'Find the mistake in a short code snippet.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodingPracticeSetupScreen(initialMode: 'Debugging'))),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.edit_note_rounded, title: 'Complete the Code',
              subtitle: 'Choose the missing part of the code.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodingPracticeSetupScreen(initialMode: 'Complete the Code'))),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.reorder_rounded, title: 'Arrange the Code',
              subtitle: 'Put code blocks in the correct order.',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodingPracticeSetupScreen(initialMode: 'Arrange the Code'))),
            ),
            const SizedBox(height: 16),

            // Meta info
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                _MetaTag(label: '10 Questions'),
                Container(width: 1, height: 18, color: AppColors.border),
                _MetaTag(label: '+1 Correct'),
                Container(width: 1, height: 18, color: AppColors.border),
                _MetaTag(label: 'No Negative Marking'),
              ]),
            ),
            const SizedBox(height: 12),
            CategoryCard(
              icon: Icons.history_rounded, title: 'Progress & History',
              subtitle: 'View past quiz scores & practice records',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CodingProgressScreen())),
            ),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}

class _MetaTag extends StatelessWidget {
  final String label;
  const _MetaTag({required this.label});
  @override
  Widget build(BuildContext context) => Text(label, style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary));
}
