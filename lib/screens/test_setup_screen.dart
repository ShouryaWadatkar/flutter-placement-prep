import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'test_question_screen.dart';

class TestSetupScreen extends StatefulWidget {
  final String? category;
  const TestSetupScreen({super.key, this.category});
  @override
  State<TestSetupScreen> createState() => _TestSetupScreenState();
}

class _TestSetupScreenState extends State<TestSetupScreen> {
  String _difficulty = 'Easy';
  int _questions = 20;
  int _timeLimit = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary),
                ),
              ),
              const SizedBox(width: 14),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(widget.category ?? 'Test Setup', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                Text('Customize your practice session.', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
            ]),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Test info card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      PillChip(label: 'Quantitative Aptitude'),
                      Row(children: [
                        const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                        const SizedBox(width: 4),
                        Text('~20 min', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                      ]),
                    ]),
                    const SizedBox(height: 10),
                    Text('Placement Aptitude Test', style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                    const SizedBox(height: 4),
                    Text('Comprehensive assessment for campus placements', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    const Divider(height: 20, color: AppColors.border),
                    Row(children: [
                      const Icon(Icons.quiz_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text('20 Questions', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                      const SizedBox(width: 16),
                      const Icon(Icons.timer_outlined, size: 14, color: AppColors.textSecondary),
                      const SizedBox(width: 6),
                      Text('~20 Minutes', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                    ]),
                  ]),
                ),
                const SizedBox(height: 24),

                Text('Difficulty', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(
                  options: ['Easy', 'Medium', 'Hard'],
                  selected: _difficulty,
                  onSelect: (v) => setState(() => _difficulty = v),
                ),
                const SizedBox(height: 24),

                Text('Questions', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(
                  options: ['10', '20', '30'],
                  selected: _questions.toString(),
                  onSelect: (v) => setState(() => _questions = int.parse(v)),
                ),
                const SizedBox(height: 24),

                Text('Time Limit', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(
                  options: ['10 min', '20 min', '30 min'],
                  selected: '$_timeLimit min',
                  onSelect: (v) => setState(() => _timeLimit = int.parse(v.replaceAll(' min', ''))),
                ),
                const SizedBox(height: 20),

                InfoBox(text: 'You can review your answers before submitting.'),
                const SizedBox(height: 24),
              ]),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: PrimaryButton(
              label: 'Start Test →',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TestQuestionScreen(totalQuestions: _questions, timeMinutes: _timeLimit))),
            ),
          ),
        ]),
      ),
    );
  }
}
