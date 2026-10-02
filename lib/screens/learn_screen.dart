import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../widgets/common_widgets.dart';

class LearnScreen extends StatelessWidget {
  const LearnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Learning Path',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Student-aware and adaptive to Amitâ€™s current knowledge state.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppTheme.muted,
              ),
            ),
            const SizedBox(height: 20),
            SecondaryNavChips(),
            const SizedBox(height: 24),
            const SectionHeader(
              title: 'PERSONALIZED LEARNING PATH',
              subtitle: 'Adapting based on mastery and prerequisite gaps',
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  _LearningPathRow(
                    label: 'âœ“ Basic Algebra',
                    mastery: '72%',
                    status: 'Mastered',
                    effort: 'Low effort',
                    color: AppTheme.green,
                  ),
                  _LearningPathRow(
                    label: 'âœ“ Polynomials',
                    mastery: '68%',
                    status: 'Mastered',
                    effort: 'Low effort',
                    color: AppTheme.green,
                  ),
                  _LearningPathRow(
                    label: 'âš  Factorisation',
                    mastery: '35%',
                    status: 'Recommended revision',
                    effort: 'Medium effort',
                    color: AppTheme.amber,
                  ),
                  _LearningPathRow(
                    label: 'â†’ Quadratic Equations',
                    mastery: '42%',
                    status: 'Learning',
                    effort: 'Medium effort',
                    color: AppTheme.royalBlue,
                  ),
                  _LearningPathRow(
                    label: 'ðŸ”’ Quadratic Formula',
                    mastery: 'Locked',
                    status: 'Prerequisite required',
                    effort: 'High effort',
                    color: AppTheme.muted,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'KNOWLEDGE GRAPH',
              subtitle: 'Concept relationships and prerequisite flow',
            ),
            const KnowledgeGraphWidget(),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'REVISION',
              subtitle: 'AI-generated session plan',
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "TODAY'S AI REVISION",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text('1. Factorisation', style: TextStyle(fontWeight: FontWeight.w700)),
                  const Text('2. Sign Handling', style: TextStyle(fontWeight: FontWeight.w700)),
                  const Text('3. Quadratic Equations', style: TextStyle(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 16),
                  Text(
                    'Reason: Based on your recent mistakes and weak prerequisite performance.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
                  ),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow_rounded),
                    label: const Text('Start Revision'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.royalBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            const SectionHeader(
              title: 'STUDENT MEMORY',
              subtitle: 'Demo history of learning progression',
            ),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  _MemoryEntry(label: 'DAY 1', detail: 'Factorisation weak', color: AppTheme.amber),
                  _MemoryEntry(label: 'DAY 7', detail: 'Improving', color: AppTheme.green),
                  _MemoryEntry(label: 'DAY 14', detail: 'Quadratic Equations practice', color: AppTheme.royalBlue),
                  _MemoryEntry(label: 'DAY 30', detail: 'Ready for next concept', color: AppTheme.cyan),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LearningPathRow extends StatelessWidget {
  final String label;
  final String mastery;
  final String status;
  final String effort;
  final Color color;

  const _LearningPathRow({
    required this.label,
    required this.mastery,
    required this.status,
    required this.effort,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppTheme.navy,
              ),
            ),
          ),
          const SizedBox(width: 12),
          _MiniStatus(tag: mastery, color: color),
          const SizedBox(width: 8),
          _MiniStatus(tag: status, color: color),
          const SizedBox(width: 8),
          Text(
            effort,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  final String tag;
  final Color color;

  const _MiniStatus({
    required this.tag,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        tag,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }
}

class _MemoryEntry extends StatelessWidget {
  final String label;
  final String detail;
  final Color color;

  const _MemoryEntry({
    required this.label,
    required this.detail,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.muted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

