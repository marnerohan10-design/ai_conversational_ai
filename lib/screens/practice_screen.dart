import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../data/demo_data.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  final TextEditingController _answerController = TextEditingController();
  int _questionIndex = 0;
  String _feedback = '';
  bool _isCorrect = false;
  bool _showHint = false;

  final List<PracticeQuestion> _questions = DemoData.practiceQuestions;

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _submitAnswer() {
    final answer = _answerController.text.trim().toLowerCase();
    final expected = _questions[_questionIndex].answer.toLowerCase();
    final isCorrect = answer == expected;

    setState(() {
      _isCorrect = isCorrect;
      _feedback = isCorrect
          ? 'Excellent. Let\'s increase the difficulty slightly and keep building the concept.'
          : 'Let\'s look at the step where the mistake happened. Sign handling and factor pair selection are the main weak points here.';
      if (isCorrect && _questionIndex < _questions.length - 1) {
        _questionIndex += 1;
        _showHint = false;
        _answerController.clear();
      }
    });
  }

  void _revealHint() {
    setState(() {
      _showHint = true;
      _feedback = 'Hint: ${_questions[_questionIndex].hint}';
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = _questions[_questionIndex];

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Adaptive Practice',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'AI adjusts difficulty based on real student performance.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.muted,
              ),
            ),
            const SizedBox(height: 22),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_questionIndex + 1}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.royalBlue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          question.difficulty,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.royalBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F7FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Topic: ${question.topic}',
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1,
                            color: AppTheme.muted,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          question.prompt,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.navy,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  TextField(
                    controller: _answerController,
                    decoration: InputDecoration(
                      labelText: 'Your answer',
                      hintText: 'Type your answer here',
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_showHint)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppTheme.amber.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        'Hint: ${question.hint}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: AppTheme.navy,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  if (_feedback.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: _isCorrect ? AppTheme.green.withValues(alpha: 0.12) : AppTheme.red.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        _feedback,
                        style: TextStyle(
                          color: _isCorrect ? AppTheme.green : AppTheme.red,
                          fontWeight: FontWeight.w700,
                          height: 1.5,
                        ),
                      ),
                    ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: _submitAnswer,
                          icon: const Icon(Icons.send_rounded),
                          label: const Text('Submit Answer'),
                          style: FilledButton.styleFrom(
                            backgroundColor: AppTheme.royalBlue,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _revealHint,
                          icon: const Icon(Icons.lightbulb_outline_rounded),
                          label: const Text('Need Hint'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.royalBlue,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            side: const BorderSide(color: AppTheme.royalBlue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'RECURRING ERROR DETECTED',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1,
                      color: AppTheme.muted,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Sign Handling',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: const [
                      _RecurrenceChip(label: 'Attempt 1 âŒ'),
                      SizedBox(width: 8),
                      _RecurrenceChip(label: 'Attempt 2 âœ“'),
                      SizedBox(width: 8),
                      _RecurrenceChip(label: 'Attempt 3 âŒ'),
                      SizedBox(width: 8),
                      _RecurrenceChip(label: 'Attempt 4 âŒ'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'AI insight: You are repeatedly making sign errors when moving terms. Practice 3 targeted sign-handling questions.',
                    style: TextStyle(
                      height: 1.6,
                      color: AppTheme.navy,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),
                  FilledButton(
                    onPressed: () {},
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.royalBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Practice Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecurrenceChip extends StatelessWidget {
  final String label;

  const _RecurrenceChip({
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: AppTheme.navy,
        ),
      ),
    );
  }
}

