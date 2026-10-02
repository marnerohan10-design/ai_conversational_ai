import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'screens/ai_teacher_screen.dart';
import 'screens/home_screen.dart';
import 'screens/learn_screen.dart';
import 'screens/practice_screen.dart';
import 'screens/progress_screen.dart';

class PersonalAiTeacherApp extends StatelessWidget {
  const PersonalAiTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal AI Teacher',
      theme: AppTheme.lightTheme(),
      debugShowCheckedModeBanner: false,
      home: const StudentLearningShell(),
    );
  }
}

class StudentLearningShell extends StatefulWidget {
  const StudentLearningShell({super.key});

  @override
  State<StudentLearningShell> createState() => _StudentLearningShellState();
}

class _StudentLearningShellState extends State<StudentLearningShell> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    AiTeacherScreen(),
    LearnScreen(),
    PracticeScreen(),
    ProgressScreen(),
  ];

  final List<NavigationDestination> _destinations = const [
    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
    NavigationDestination(icon: Icon(Icons.smart_toy_outlined), selectedIcon: Icon(Icons.smart_toy), label: 'AI Teacher'),
    NavigationDestination(icon: Icon(Icons.school_outlined), selectedIcon: Icon(Icons.school), label: 'Learn'),
    NavigationDestination(icon: Icon(Icons.task_alt_outlined), selectedIcon: Icon(Icons.task_alt), label: 'Practice'),
    NavigationDestination(icon: Icon(Icons.pie_chart_outline), selectedIcon: Icon(Icons.pie_chart), label: 'Progress'),
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 980) {
      return Scaffold(
        body: Row(
          children: [
            Container(
              width: 220,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 24),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.royalBlue, AppTheme.cyan],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(Icons.psychology, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'PERSONAL AI TEACHER',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: AppTheme.navy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ..._destinations.map((destination) {
                    final index = _destinations.indexOf(destination);
                    final isSelected = index == _selectedIndex;
                    final icon = destination.icon as Icon;
                    final selectedIcon = destination.selectedIcon as Icon;
                    return InkWell(
                      onTap: () => setState(() => _selectedIndex = index),
                      borderRadius: BorderRadius.circular(16),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                        decoration: BoxDecoration(
                          color: isSelected ? AppTheme.royalBlue.withValues(alpha: 0.08) : Colors.transparent,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isSelected ? selectedIcon.icon : icon.icon,
                              color: isSelected ? AppTheme.royalBlue : AppTheme.muted,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              destination.label,
                              style: TextStyle(
                                color: isSelected ? AppTheme.royalBlue : AppTheme.navy,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.auto_awesome, color: AppTheme.lavender),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Student asks â†’ AI diagnoses â†’ AI teaches â†’ Student practices â†’ AI adapts',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.navy,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(child: _pages[_selectedIndex]),
          ],
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: _destinations,
      ),
    );
  }
}

