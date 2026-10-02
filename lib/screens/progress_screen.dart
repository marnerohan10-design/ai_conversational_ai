import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../data/demo_data.dart';
import '../widgets/common_widgets.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progress & Analytics',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
            const SizedBox(height: 8),
            const PillBadge(
              label: 'ILLUSTRATIVE DATA',
              color: AppTheme.amber,
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                StatCard(
                  label: 'Overall mastery',
                  value: '68%',
                  caption: 'OVERALL',
                  icon: Icons.psychology_rounded,
                  color: AppTheme.royalBlue,
                ),
                StatCard(
                  label: 'Practice accuracy',
                  value: '79%',
                  caption: 'ACCURACY',
                  icon: Icons.analytics_outlined,
                  color: AppTheme.green,
                ),
                StatCard(
                  label: 'Learning streak',
                  value: '7 days',
                  caption: 'STREAK',
                  icon: Icons.local_fire_department_rounded,
                  color: AppTheme.amber,
                ),
                StatCard(
                  label: 'Time spent',
                  value: '4.8h',
                  caption: 'TIME',
                  icon: Icons.access_time_rounded,
                  color: AppTheme.cyan,
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'MASTERY TREND',
              subtitle: 'Illustrative learning trajectory',
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Mathematics', style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.navy)),
                      Text('68%', style: TextStyle(fontWeight: FontWeight.w800, color: AppTheme.royalBlue)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 140,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(8, (index) {
                        final values = [18, 26, 32, 28, 35, 44, 54, 68];
                        final height = values[index].toDouble();
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                width: 30,
                                height: height * 1.4,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                                  gradient: LinearGradient(
                                    colors: [AppTheme.cyan, AppTheme.royalBlue],
                                    stops: const [0.0, 1.0],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'TOPIC PERFORMANCE',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppTheme.muted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _TopicPerformanceRow(label: 'Algebra', value: 72, color: AppTheme.green),
                        _TopicPerformanceRow(label: 'Factorisation', value: 35, color: AppTheme.amber),
                        _TopicPerformanceRow(label: 'Quadratic Equations', value: 42, color: AppTheme.royalBlue),
                        _TopicPerformanceRow(label: 'Quadratic Formula', value: 12, color: AppTheme.lavender),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PRACTICE ACTIVITY',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                            color: AppTheme.muted,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _TopicPerformanceRow(label: 'Completed sets', value: 18, color: AppTheme.green),
                        _TopicPerformanceRow(label: 'Revised concepts', value: 5, color: AppTheme.cyan),
                        _TopicPerformanceRow(label: 'Mistakes reviewed', value: 7, color: AppTheme.amber),
                        _TopicPerformanceRow(label: 'Prerequisite gaps', value: 2, color: AppTheme.red),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'MISTAKE BOOK',
              subtitle: 'Review of recurring misconceptions',
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: DemoData.mistakes.map((mistake) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              mistake.topic,
                              style: const TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.navy,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              decoration: BoxDecoration(
                                color: AppTheme.red.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                mistake.category,
                                style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: AppTheme.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Question: ${mistake.question}',
                          style: const TextStyle(fontWeight: FontWeight.w600, color: AppTheme.navy),
                        ),
                        Text(
                          'Student answer: ${mistake.studentAnswer}',
                          style: const TextStyle(color: AppTheme.muted),
                        ),
                        Text(
                          'Correct answer: ${mistake.correctAnswer}',
                          style: const TextStyle(color: AppTheme.muted),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Why it was wrong: ${mistake.reason}',
                          style: const TextStyle(color: AppTheme.muted, height: 1.5),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopicPerformanceRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _TopicPerformanceRow({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
              Text(
                '${value.toInt()}%',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 10,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}

