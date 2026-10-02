import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height - 100,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Good morning, Amit ðŸ‘‹',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.navy,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Ready to continue your learning journey?',
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: AppTheme.muted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 52,
                    height: 52,
                    decoration: BoxDecoration(
                      color: AppTheme.royalBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.person, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SecondaryNavChips(),
              const SizedBox(height: 22),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  StatCard(
                    label: 'Current Learning Streak',
                    value: '7 days',
                    caption: 'STREAK',
                    icon: Icons.local_fire_department_rounded,
                    color: AppTheme.amber,
                  ),
                  StatCard(
                    label: 'Concept Mastery',
                    value: '68%',
                    caption: 'AVG',
                    icon: Icons.trending_up_rounded,
                    color: AppTheme.green,
                  ),
                  StatCard(
                    label: "Today's Learning Goal",
                    value: 'Factorisation',
                    caption: 'GOAL',
                    icon: Icons.flag_rounded,
                    color: AppTheme.royalBlue,
                  ),
                  StatCard(
                    label: 'Practice Accuracy',
                    value: '79%',
                    caption: 'ACCURACY',
                    icon: Icons.check_circle_outline_rounded,
                    color: AppTheme.lavender,
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEEF4FF), Color(0xFFEAFBFF)],
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const PillBadge(
                            label: 'DEMO / ILLUSTRATIVE DATA',
                            color: AppTheme.royalBlue,
                          ),
                          const SizedBox(height: 18),
                          const Text(
                            'NEXT BEST LEARNING STEP',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1,
                              color: AppTheme.muted,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            'Revise Factorisation',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.navy,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Your recent Quadratic Equation attempts show a prerequisite gap in Factorisation. Your mastery is 35% compared with a 42% current topic focus.',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.6,
                              color: AppTheme.muted,
                            ),
                          ),
                          const SizedBox(height: 22),
                          Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: [
                              FilledButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.auto_awesome),
                                label: const Text('Start Learning'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppTheme.royalBlue,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                              OutlinedButton.icon(
                                onPressed: () {},
                                icon: const Icon(Icons.timeline),
                                label: const Text('Run Demo Journey'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: AppTheme.royalBlue,
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                                  side: const BorderSide(color: AppTheme.royalBlue),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 20),
                    Container(
                      width: 170,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Quadratic Equations',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.muted,
                            ),
                          ),
                          const SizedBox(height: 14),
                          CircularProgressBadge(
                            percentage: 42,
                            label: 'Mastery',
                          ),
                          const SizedBox(height: 18),
                          CircularProgressBadge(
                            percentage: 35,
                            label: 'Factorisation',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const SectionHeader(
                title: 'CONTINUE LEARNING',
                subtitle: 'Continue from where you left off',
              ),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: AppTheme.royalBlue.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(Icons.calculate_rounded, color: AppTheme.royalBlue),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Quadratic Equations',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.navy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Lesson progress â€¢ 3/5 activities complete',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppTheme.muted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppTheme.muted),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'PROGRESS SNAPSHOT',
                          subtitle: 'Illustrative mastery overview',
                        ),
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Mathematics',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppTheme.navy,
                                    ),
                                  ),
                                  Text(
                                    '68%',
                                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                      color: AppTheme.royalBlue,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(999),
                                child: const LinearProgressIndicator(
                                  value: 0.68,
                                  minHeight: 12,
                                  backgroundColor: Color(0xFFE5E7EB),
                                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.royalBlue),
                                ),
                              ),
                              const SizedBox(height: 18),
                              Row(
                                children: [
                                  Expanded(
                                    child: _ProgressChunk(
                                      label: 'Algebra',
                                      value: 72,
                                      color: AppTheme.green,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _ProgressChunk(
                                      label: 'Geometry',
                                      value: 64,
                                      color: AppTheme.cyan,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SectionHeader(
                          title: 'AI INSIGHT',
                          subtitle: 'Adaptive guidance',
                        ),
                        InfoCard(
                          title: 'Learning insight',
                          body: "You are improving in Algebra. Let's strengthen Factorisation before moving to the next concept.",
                          accent: AppTheme.royalBlue,
                        ),
                        const SizedBox(height: 16),
                        const SectionHeader(
                          title: 'RECENT MISTAKES',
                          subtitle: 'Targeted follow-up',
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: const [
                              _MistakeRow(
                                title: 'Sign handling',
                                value: '2 errors this week',
                              ),
                              SizedBox(height: 10),
                              _MistakeRow(
                                title: 'Factor pair selection',
                                value: '1 error this week',
                              ),
                              SizedBox(height: 10),
                              _MistakeRow(
                                title: 'Quadratic roots',
                                value: '3 errors this week',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProgressChunk extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _ProgressChunk({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w700, color: AppTheme.navy)),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            '${value.toInt()}%',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MistakeRow extends StatelessWidget {
  final String title;
  final String value;

  const _MistakeRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: AppTheme.red,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              color: AppTheme.navy,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppTheme.muted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

