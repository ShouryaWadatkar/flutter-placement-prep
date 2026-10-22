import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'interview_question_screen.dart';

class InterviewSetupScreen extends StatefulWidget {
  const InterviewSetupScreen({super.key});
  @override
  State<InterviewSetupScreen> createState() => _InterviewSetupScreenState();
}

class _InterviewSetupScreenState extends State<InterviewSetupScreen> {
  String _role = 'Software Engineer';
  String _format = 'AI Technical Interview';
  String _persona = 'Friendly & Conversational';
  int _length = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
              const SizedBox(width: 14),
              Text('Interview Setup', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Icon(Icons.mic_rounded, color: AppColors.primary, size: 14),
                    const SizedBox(width: 6),
                    Text('AI Voice Interview • Microphone Required', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ]),
                ),
                const SizedBox(height: 8),
                Text('Configure your AI voice interview practice.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary)),
                const SizedBox(height: 24),

                Text('Target Role', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(options: ['Software Engineer', 'Frontend Dev', 'Data Analyst'], selected: _role, onSelect: (v) => setState(() => _role = v)),
                const SizedBox(height: 24),

                Text('Interview Format', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(options: ['AI Technical Interview', 'HR / Behavioral'], selected: _format, onSelect: (v) => setState(() => _format = v)),
                const SizedBox(height: 24),

                Text('AI Interviewer Persona', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(options: ['Friendly & Conversational', 'Strict & Challenging'], selected: _persona, onSelect: (v) => setState(() => _persona = v)),
                const SizedBox(height: 24),

                Text('Practice Length', style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 12),
                SelectChipGroup(options: ['5 Mins', '10 Mins', '15 Mins'], selected: '$_length Mins', onSelect: (v) => setState(() => _length = int.parse(v.replaceAll(' Mins', '')))),
                const SizedBox(height: 20),

                InfoBox(icon: Icons.info_outline_rounded, text: 'The AI will ask questions by speaking aloud. You will respond using your microphone with real-time speech evaluation.'),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: PrimaryButton(
              label: '🎙️  Start Voice Interview',
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const InterviewQuestionScreen())),
            ),
          ),
        ]),
      ),
    );
  }
}
