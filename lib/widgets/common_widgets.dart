import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.muted,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String caption;
  final IconData icon;
  final Color color;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.caption,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  caption,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppTheme.muted,
            ),
          ),
        ],
      ),
    );
  }
}

class PillBadge extends StatelessWidget {
  final String label;
  final Color color;

  const PillBadge({
    super.key,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.7,
          color: color,
        ),
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String body;
  final Color accent;
  final Widget? trailing;

  const InfoCard({
    super.key,
    required this.title,
    required this.body,
    required this.accent,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withValues(alpha: 0.15)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 10,
            height: 10,
            margin: const EdgeInsets.only(top: 8, right: 12),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppTheme.muted,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class JourneyTimeline extends StatelessWidget {
  final int activeStage;

  const JourneyTimeline({
    super.key,
    required this.activeStage,
  });

  @override
  Widget build(BuildContext context) {
    final stages = [
      'ASK',
      'UNDERSTAND',
      'DIAGNOSE',
      'RETRIEVE',
      'TEACH',
      'PRACTICE',
      'ANALYZE',
      'REMEMBER',
      'ADAPT',
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DEMO JOURNEY',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 98,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: stages.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final isActive = index == activeStage;
                final isPast = index < activeStage;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isActive
                            ? AppTheme.royalBlue
                            : isPast
                                ? AppTheme.mint
                                : const Color(0xFFE5E7EB),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          color: isActive || isPast ? Colors.white : AppTheme.muted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    RotatedBox(
                      quarterTurns: 0,
                      child: SizedBox(
                        width: 82,
                        child: Text(
                          stages[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                            color: isActive ? AppTheme.royalBlue : AppTheme.muted,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class KnowledgeGraphWidget extends StatelessWidget {
  const KnowledgeGraphWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final nodes = [
      const _GraphNode(label: 'Algebra', size: 52, color: AppTheme.royalBlue),
      const _GraphNode(label: 'Factorisation', size: 64, color: AppTheme.amber),
      const _GraphNode(label: 'Quadratic Equations', size: 82, color: AppTheme.cyan),
      const _GraphNode(label: 'Quadratic Formula', size: 58, color: AppTheme.lavender),
    ];

    return Container(
      height: 220,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 110,
            top: 20,
            child: CustomPaint(
              size: const Size(220, 170),
              painter: _GraphConnectorPainter(),
            ),
          ),
          ...List.generate(nodes.length, (index) {
            final node = nodes[index];
            final position = _positionForNode(index);
            return Positioned(
              left: position.dx,
              top: position.dy,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: node.size,
                    height: node.size,
                    decoration: BoxDecoration(
                      color: node.color.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(node.size / 2),
                      border: Border.all(
                        color: node.color.withValues(alpha: 0.7),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        node.label,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _graphTitle(index),
                    style: const TextStyle(
                      fontSize: 10,
                      color: AppTheme.muted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Offset _positionForNode(int index) {
    switch (index) {
      case 0:
        return const Offset(20, 120);
      case 1:
        return const Offset(150, 10);
      case 2:
        return const Offset(128, 90);
      case 3:
        return const Offset(230, 120);
      default:
        return const Offset(20, 120);
    }
  }

  String _graphTitle(int index) {
    switch (index) {
      case 0:
        return 'Mastered';
      case 1:
        return 'Weak';
      case 2:
        return 'Learning';
      case 3:
        return 'Locked';
      default:
        return '';
    }
  }
}

class _GraphNode {
  final String label;
  final double size;
  final Color color;

  const _GraphNode({
    required this.label,
    required this.size,
    required this.color,
  });
}

class _GraphConnectorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.royalBlue.withValues(alpha: 0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(20, 80);
    path.lineTo(120, 30);
    path.moveTo(120, 30);
    path.lineTo(180, 90);
    path.moveTo(180, 90);
    path.lineTo(240, 120);

    canvas.drawPath(path, paint);

    final dotPaint = Paint()..color = AppTheme.royalBlue.withValues(alpha: 0.5);
    for (final point in [
      const Offset(20, 80),
      const Offset(120, 30),
      const Offset(180, 90),
      const Offset(240, 120),
    ]) {
      canvas.drawCircle(point, 5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GraphConnectorPainter oldDelegate) => false;
}

class CircularProgressBadge extends StatelessWidget {
  final double percentage;
  final String label;

  const CircularProgressBadge({
    super.key,
    required this.percentage,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: CircularProgressIndicator(
                value: percentage / 100,
                strokeWidth: 8,
                backgroundColor: const Color(0xFFE5E7EB),
                valueColor: const AlwaysStoppedAnimation<Color>(AppTheme.royalBlue),
              ),
            ),
            Text(
              '${percentage.toInt()}%',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppTheme.muted,
          ),
        ),
      ],
    );
  }
}

class SecondaryNavChips extends StatelessWidget {
  const SecondaryNavChips({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Learning Profile',
      'Learning Path',
      'Revision',
      'Mistake Book',
      'Achievements',
      'Notifications',
      'Settings',
      'Voice',
      'Language',
      'Privacy',
      'Account',
    ];

    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Text(
            item,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppTheme.navy,
            ),
          ),
        );
      }).toList(),
    );
  }
}

