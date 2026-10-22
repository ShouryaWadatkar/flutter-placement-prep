import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'interview_result_screen.dart';

final _interviewQuestions = [
  'What is the difference between a class and an object?',
  'Explain the concept of inheritance in OOP.',
  'What is the difference between stack and queue?',
  'How does a hash map work internally?',
  'What is the time complexity of binary search?',
];

final _modelAnswers = [
  'A class is a blueprint that defines properties and methods, while an object is an instance of that class.',
  'Inheritance allows a child class to acquire properties and methods from a parent class, promoting code reuse.',
  'A stack follows LIFO (Last In, First Out) and a queue follows FIFO (First In, First Out).',
  'A hash map uses a hash function to compute an index into an array of buckets where values are stored.',
  'Binary search has O(log n) time complexity as it halves the search space each iteration.',
];

class InterviewQuestionScreen extends StatefulWidget {
  final bool initialIsAnswered;
  const InterviewQuestionScreen({super.key, this.initialIsAnswered = false});
  @override
  State<InterviewQuestionScreen> createState() => _InterviewQuestionScreenState();
}

class _InterviewQuestionScreenState extends State<InterviewQuestionScreen> {
  int _current = 0;
  bool _isRecording = true;
  late bool _answered;
  int _seconds = 105;
  Timer? _timer;

  final _transcript = '"A class is like a blueprint or template, while an object is a real instance created from that class..."';

  @override
  void initState() {
    super.initState();
    _answered = widget.initialIsAnswered;
    if (_answered) {
      _isRecording = false;
    } else {
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (_seconds <= 0) { _timer?.cancel(); } else {
          setState(() => _seconds--);
        }
      });
    }
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  String get _timeStr => '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

  void _submit() {
    setState(() { _answered = true; _isRecording = false; });
  }

  @override
  Widget build(BuildContext context) {
    if (_answered) {
      return _AnsweredView(
      question: _interviewQuestions[_current],
      transcript: _transcript,
      modelAnswer: _modelAnswers[_current],
      current: _current,
      total: _interviewQuestions.length,
      onNext: () {
        if (_current < _interviewQuestions.length - 1) {
          setState(() { _current++; _answered = false; _isRecording = true; _seconds = 105; });
          _timer = Timer.periodic(const Duration(seconds: 1), (_) {
            if (_seconds <= 0) {
              _timer?.cancel();
            } else {
              setState(() => _seconds--);
            }
          });
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InterviewResultScreen()));
        }
      },
      onRepeat: () => setState(() { _answered = false; _isRecording = true; }),
    );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary))),
              const SizedBox(width: 12),
              Expanded(child: Text('AI VOICE INTERVIEW', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary, letterSpacing: 0.05))),
              TimerBadge(time: _timeStr),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Question ${_current + 1} of ${_interviewQuestions.length}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                Text('${((_current + 1) / _interviewQuestions.length * 100).round()}%', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 8),
              AppProgressBar(value: (_current + 1) / _interviewQuestions.length),
            ]),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // AI question card
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        const Icon(Icons.volume_up_rounded, color: AppColors.primary, size: 16),
                        const SizedBox(width: 6),
                        Text('AI Interviewer', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.primary)),
                      ]),
                      GestureDetector(child: Row(children: [
                        const Icon(Icons.replay_rounded, size: 14, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text('Replay Audio', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textMuted)),
                      ])),
                    ]),
                    const SizedBox(height: 10),
                    Text(_interviewQuestions[_current], style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.5)),
                  ]),
                ),
                const SizedBox(height: 16),

                // Listening status
                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(children: [
                    Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                    const SizedBox(width: 8),
                    Text('Listening to your answer...', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
                  ]),
                  Text('Voice Input Active', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                ]),
                const SizedBox(height: 16),

                // Transcript
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Icon(Icons.subtitles_outlined, size: 14, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Text('LIVE SPEECH-TO-TEXT TRANSCRIPT', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.08)),
                    ]),
                    const SizedBox(height: 10),
                    Text(_transcript, style: GoogleFonts.inter(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.textPrimary, height: 1.6)),
                    const SizedBox(height: 8),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Container(width: 6, height: 6, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                      const SizedBox(width: 5),
                      Text('Transcribing live', style: GoogleFonts.inter(fontSize: 11, color: AppColors.primary)),
                    ]),
                  ]),
                ),
                const SizedBox(height: 24),

                // Waveform + mic
                const WaveformWidget(),
                const SizedBox(height: 20),
                Center(child: GestureDetector(
                  onTap: () => setState(() => _isRecording = !_isRecording),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 70, height: 70,
                    decoration: BoxDecoration(
                      color: _isRecording ? AppColors.primary : AppColors.textMuted,
                      shape: BoxShape.circle,
                      boxShadow: _isRecording ? [BoxShadow(color: AppColors.primary.withAlpha(80), blurRadius: 20, spreadRadius: 4)] : [],
                    ),
                    child: const Icon(Icons.mic_rounded, color: Colors.white, size: 30),
                  ),
                )),
                const SizedBox(height: 8),
                Center(child: Text('Tap mic to pause recording', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary))),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(children: [
              PrimaryButton(label: '✓  Done Speaking & Submit', onTap: _submit),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  if (_current < _interviewQuestions.length - 1) {
                    setState(() { _current++; });
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const InterviewResultScreen()));
                  }
                },
                child: Text('Skip Question', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _AnsweredView extends StatelessWidget {
  final String question, transcript, modelAnswer;
  final int current, total;
  final VoidCallback onNext, onRepeat;
  const _AnsweredView({required this.question, required this.transcript, required this.modelAnswer, required this.current, required this.total, required this.onNext, required this.onRepeat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(children: [
              GestureDetector(onTap: () => Navigator.pop(context),
                child: Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18))),
              const SizedBox(width: 12),
              Expanded(child: Text('AI VOICE INTERVIEW', style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: AppColors.textPrimary))),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Question ${current + 1} of $total', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                Text('${current + 1}/$total', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 8),
              AppProgressBar(value: (current + 1) / total),
            ]),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(question, style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.4)),
                const SizedBox(height: 16),

                // Recorded answer
                Text('YOUR SPOKEN RESPONSE', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: AppColors.textMuted, letterSpacing: 0.1)),
                const SizedBox(height: 6),
                Row(children: [
                  Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle), child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20)),
                  const SizedBox(width: 12),
                  Expanded(child: Container(height: 4, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(99)),
                    child: FractionallySizedBox(alignment: Alignment.centerLeft, widthFactor: 0.6, child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(99)))))),
                  const SizedBox(width: 12),
                  Text('00:38', style: GoogleFonts.inter(fontSize: 12, color: AppColors.textSecondary)),
                  const SizedBox(width: 8),
                  PillChip(label: '🎙️ Recorded', bg: AppColors.successLight, fg: AppColors.success),
                ]),
                const SizedBox(height: 8),
                Text(transcript, style: GoogleFonts.inter(fontSize: 13, fontStyle: FontStyle.italic, color: AppColors.textPrimary, height: 1.6)),
                const SizedBox(height: 16),

                // Voice metrics
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                  child: Column(children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        const Icon(Icons.person_rounded, size: 16, color: AppColors.primary),
                        const SizedBox(width: 6),
                        Text('VOICE DELIVERY METRICS', style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary, letterSpacing: 0.06)),
                      ]),
                      PillChip(label: 'Overall: Good', bg: AppColors.successLight, fg: AppColors.success),
                    ]),
                    const SizedBox(height: 12),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                      _MetricCol(label: 'Clarity', value: '92%', sub: 'Very Clear', color: AppColors.success),
                      _MetricCol(label: 'Pace', value: '135 wpm', sub: 'Optimal', color: AppColors.primary),
                      _MetricCol(label: 'Confidence', value: 'High', sub: 'Steady', color: AppColors.success),
                    ]),
                  ]),
                ),
                const SizedBox(height: 16),

                // Model answer
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Row(children: [
                        const Icon(Icons.lightbulb_outline_rounded, size: 16, color: AppColors.textPrimary),
                        const SizedBox(width: 6),
                        Text('Model Answer', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                      ]),
                      Row(children: [
                        const Icon(Icons.volume_up_outlined, size: 14, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text('Listen to AI', style: GoogleFonts.inter(fontSize: 12, color: AppColors.primary, fontWeight: FontWeight.w600)),
                      ]),
                    ]),
                    const SizedBox(height: 10),
                    Text(modelAnswer, style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary, height: 1.6)),
                  ]),
                ),
                const SizedBox(height: 24),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(children: [
              PrimaryButton(label: 'Next Question →', onTap: onNext),
              const SizedBox(height: 10),
              OutlineButton2(label: '🎙️  Practice Speaking Again', onTap: onRepeat),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _MetricCol extends StatelessWidget {
  final String label, value, sub;
  final Color color;
  const _MetricCol({required this.label, required this.value, required this.sub, required this.color});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(label, style: GoogleFonts.inter(fontSize: 11, color: AppColors.textSecondary)),
    const SizedBox(height: 4),
    Text(value, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: color)),
    Text(sub, style: GoogleFonts.inter(fontSize: 11, color: color)),
  ]);
}
