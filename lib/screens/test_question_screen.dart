import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'test_result_screen.dart';

class _Question {
  final String topic;
  final String text;
  final List<String> options;
  final int correct;
  _Question({required this.topic, required this.text, required this.options, required this.correct});
}

final _sampleQuestions = [
  _Question(topic: 'Percentages', text: 'A shopkeeper offers a 20% discount on an item marked at ₹500. What is the selling price?', options: ['₹350', '₹400', '₹420', '₹450'], correct: 1),
  _Question(topic: 'Ratios', text: 'If A:B = 3:4 and B:C = 5:6, what is A:C?', options: ['5:8', '15:24', '5:8', '3:5'], correct: 1),
  _Question(topic: 'Time & Work', text: 'A can do a job in 10 days. B can do it in 15 days. How many days do they take together?', options: ['5 days', '6 days', '8 days', '12 days'], correct: 1),
  _Question(topic: 'Speed', text: 'A train travels 240 km in 4 hours. What is its speed in km/h?', options: ['40', '50', '60', '80'], correct: 2),
  _Question(topic: 'Algebra', text: 'If x + y = 10 and x - y = 4, what is x?', options: ['3', '5', '7', '9'], correct: 2),
  _Question(topic: 'Probability', text: 'What is the probability of getting a head when a fair coin is tossed?', options: ['1/4', '1/3', '1/2', '3/4'], correct: 2),
  _Question(topic: 'Number Series', text: 'What comes next: 2, 6, 18, 54, ?', options: ['108', '162', '216', '324'], correct: 1),
  _Question(topic: 'Profit & Loss', text: 'A product bought for ₹800 is sold for ₹1000. Profit percentage?', options: ['15%', '20%', '25%', '30%'], correct: 2),
  _Question(topic: 'Simple Interest', text: 'SI on ₹5000 at 8% for 3 years?', options: ['₹1000', '₹1200', '₹1500', '₹2000'], correct: 1),
  _Question(topic: 'Geometry', text: 'Area of a circle with radius 7 cm? (Use π = 22/7)', options: ['154 cm²', '176 cm²', '196 cm²', '210 cm²'], correct: 0),
];

class TestQuestionScreen extends StatefulWidget {
  final int totalQuestions;
  final int timeMinutes;
  const TestQuestionScreen({super.key, this.totalQuestions = 20, this.timeMinutes = 20});

  @override
  State<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends State<TestQuestionScreen> {
  int _current = 0;
  late int _seconds;
  Timer? _timer;
  final Map<int, int?> _answers = {};
  final Set<int> _flagged = {};

  @override
  void initState() {
    super.initState();
    _seconds = widget.timeMinutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds <= 0) { _timer?.cancel(); _submit(); } else { setState(() => _seconds--); }
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  String get _timeStr {
    final m = (_seconds ~/ 60).toString().padLeft(2, '0');
    final s = (_seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  List<_Question> get _questions => _sampleQuestions.take(widget.totalQuestions.clamp(1, 10)).toList();

  void _submit() {
    _timer?.cancel();
    int correct = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_answers[i] == _questions[i].correct) correct++;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (_) => TestResultScreen(total: _questions.length, correct: correct, timeTaken: widget.timeMinutes * 60 - _seconds),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final q = _questions[_current];
    final progress = (_current + 1) / _questions.length;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(children: [
          // Top bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Row(children: [
              GestureDetector(
                onTap: () => _showExitDialog(),
                child: Container(width: 36, height: 36,
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(99), border: Border.all(color: AppColors.border)),
                  child: const Icon(Icons.arrow_back_rounded, size: 18, color: AppColors.textPrimary)),
              ),
              const SizedBox(width: 12),
              Expanded(child: Text('Quantitative Aptitude', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
              TimerBadge(time: _timeStr),
            ]),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Question ${_current + 1} of ${_questions.length}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                Text('${(_current / _questions.length * 100).round()}% completed', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 8),
              AppProgressBar(value: progress),
            ]),
          ),
          const SizedBox(height: 16),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Question card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    PillChip(label: q.topic),
                    const SizedBox(height: 12),
                    Text(q.text, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary, height: 1.5)),
                  ]),
                ),
                const SizedBox(height: 16),

                // Options
                ...List.generate(q.options.length, (i) {
                  final state = _answers[_current] == i ? OptionState.selected : OptionState.normal;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: McqOption(
                      letter: ['A', 'B', 'C', 'D'][i],
                      text: q.options[i],
                      state: state,
                      onTap: () => setState(() => _answers[_current] = i),
                    ),
                  );
                }),
                const SizedBox(height: 16),
              ]),
            ),
          ),

          // Bottom bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Row(children: [
                  Checkbox(
                    value: _flagged.contains(_current),
                    onChanged: (_) => setState(() => _flagged.contains(_current) ? _flagged.remove(_current) : _flagged.add(_current)),
                    activeColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                  ),
                  Text('Mark for Review', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                ]),
                GestureDetector(
                  onTap: () => setState(() => _flagged.contains(_current) ? _flagged.remove(_current) : _flagged.add(_current)),
                  child: Row(children: [
                    const Icon(Icons.flag_outlined, size: 16, color: AppColors.textSecondary),
                    const SizedBox(width: 4),
                    Text('Flag', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                  ]),
                ),
              ]),
              const SizedBox(height: 8),
              Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _current > 0 ? () => setState(() => _current--) : null,
                    icon: const Icon(Icons.chevron_left_rounded, size: 18),
                    label: Text('Previous', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textPrimary,
                      side: const BorderSide(color: AppColors.border),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      if (_current < _questions.length - 1) {
                        setState(() => _current++);
                      } else {
                        _submit();
                      }
                    },
                    icon: Text(_current < _questions.length - 1 ? 'Next' : 'Submit', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600)),
                    label: Icon(_current < _questions.length - 1 ? Icons.chevron_right_rounded : Icons.check_rounded, size: 18),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary, foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ]),
      ),
    );
  }

  void _showExitDialog() {
    showDialog(context: context, builder: (_) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text('Exit Test?', style: GoogleFonts.inter(fontWeight: FontWeight.w700)),
      content: Text('Your progress will be lost.', style: GoogleFonts.inter()),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel', style: GoogleFonts.inter(color: AppColors.textSecondary))),
        ElevatedButton(
          onPressed: () { Navigator.pop(context); Navigator.pop(context); },
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white),
          child: Text('Exit', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        ),
      ],
    ));
  }
}
