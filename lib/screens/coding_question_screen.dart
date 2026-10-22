import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme.dart';
import '../core/widgets.dart';
import 'coding_result_screen.dart';

class _CodingQ {
  final String topic, question, code, language;
  final List<String> options;
  final int correct;
  _CodingQ({required this.topic, required this.question, required this.code, required this.language, required this.options, required this.correct});
}

final _outputQs = [
  _CodingQ(topic: 'Python', question: 'What is the output of this code?', code: 'x = 5\nprint(x * 2)', language: 'PYTHON', options: ['5', '10', '25', 'Error'], correct: 1),
  _CodingQ(topic: 'Python', question: 'What is the output of this code?', code: 'lst = [1, 2, 3]\nprint(len(lst))', language: 'PYTHON', options: ['0', '2', '3', '4'], correct: 2),
  _CodingQ(topic: 'Java', question: 'What is the output?', code: 'int a = 10, b = 3;\nSystem.out.println(a % b);', language: 'JAVA', options: ['0', '1', '3', '10'], correct: 1),
];

final _debugQs = [
  _CodingQ(topic: 'Python', question: 'What is wrong with this code?', code: 'numbers = [1, 2, 3]\nprint(numbers[3])', language: 'PYTHON', options: ['Nothing is wrong', 'Index 3 is out of range', 'The list cannot contain integers', 'print() cannot be used with a list'], correct: 1),
  _CodingQ(topic: 'Python', question: 'Identify the bug:', code: 'def greet(name)\n    print("Hello", name)\ngreet("Alice")', language: 'PYTHON', options: ['Missing return statement', 'Missing colon after function definition', 'Wrong print syntax', 'No bug'], correct: 1),
];

final _completeQs = [
  _CodingQ(topic: 'Python', question: 'Choose the correct missing part:', code: 'def add(a, b):\n    return ___\nadd(3, 4)', language: 'PYTHON', options: ['a - b', 'a * b', 'a + b', 'a / b'], correct: 2),
  _CodingQ(topic: 'Python', question: 'What goes in the blank?', code: 'for i in ___(5):\n    print(i)', language: 'PYTHON', options: ['list', 'range', 'len', 'int'], correct: 1),
];

class CodingQuestionScreen extends StatefulWidget {
  final String type;
  const CodingQuestionScreen({super.key, required this.type});
  @override
  State<CodingQuestionScreen> createState() => _CodingQuestionScreenState();
}

class _CodingQuestionScreenState extends State<CodingQuestionScreen> {
  int _current = 0;
  int _seconds = 600;
  Timer? _timer;
  final Map<int, int?> _answers = {};

  List<_CodingQ> get _qs {
    if (widget.type == 'Debugging') return _debugQs;
    if (widget.type == 'Complete the Code') return _completeQs;
    return _outputQs;
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_seconds <= 0) { _timer?.cancel(); _submit(); } else {
        setState(() => _seconds--);
      }
    });
  }

  @override
  void dispose() { _timer?.cancel(); super.dispose(); }

  String get _timeStr => '${(_seconds ~/ 60).toString().padLeft(2, '0')}:${(_seconds % 60).toString().padLeft(2, '0')}';

  void _submit() {
    _timer?.cancel();
    int correct = 0;
    for (int i = 0; i < _qs.length; i++) {
      if (_answers[i] == _qs[i].correct) correct++;
    }
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => CodingResultScreen(type: widget.type, correct: correct, total: _qs.length)));
  }

  @override
  Widget build(BuildContext context) {
    final q = _qs[_current];
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
              Expanded(child: Text(widget.type, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
              TimerBadge(time: _timeStr),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('Question ${_current + 1} of ${_qs.length}', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
                Text('${(_current / _qs.length * 100).round()}% completed', style: GoogleFonts.inter(fontSize: 13, color: AppColors.textSecondary)),
              ]),
              const SizedBox(height: 8),
              AppProgressBar(value: (_current + 1) / _qs.length),
            ]),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(q.question, style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
                const SizedBox(height: 14),
                CodeBlock(code: q.code, language: q.language, showLineNumbers: widget.type == 'Debugging'),
                if (widget.type == 'Debugging') ...[const SizedBox(height: 10), Text('Identify the issue.', style: GoogleFonts.inter(fontSize: 14, color: AppColors.textSecondary))],
                const SizedBox(height: 16),
                ...List.generate(q.options.length, (i) {
                  final state = _answers[_current] == i ? OptionState.selected : OptionState.normal;
                  return Padding(padding: const EdgeInsets.only(bottom: 10),
                    child: McqOption(letter: ['A', 'B', 'C', 'D'][i], text: q.options[i], state: state, onTap: () => setState(() => _answers[_current] = i)));
                }),
              ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: PrimaryButton(
              label: _current < _qs.length - 1 ? 'Next →' : 'Submit Answer',
              onTap: () {
                if (_current < _qs.length - 1) {
                  setState(() => _current++);
                } else {
                  _submit();
                }
              },
            ),
          ),
        ]),
      ),
    );
  }
}
