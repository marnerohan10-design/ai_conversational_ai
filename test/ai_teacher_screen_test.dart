import 'package:ai_conversational_ai/screens/ai_teacher_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  testWidgets('lesson actions respond to taps', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AiTeacherScreen())),
    );
    await tester.pump(const Duration(milliseconds: 500));

    await tester.ensureVisible(find.text('Show Example'));
    await tester.tap(find.text('Show Example'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 500));

    expect(find.text('Worked Example'), findsOneWidget);
  });

  testWidgets('student can send a question to the demo tutor', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AiTeacherScreen())),
    );
    await tester.pump(const Duration(milliseconds: 500));

    await tester.enterText(
      find.byKey(const ValueKey('tutor-question-input')),
      'What is Java?',
    );
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(
      tester
          .widget<TextField>(find.byKey(const ValueKey('tutor-question-input')))
          .controller!
          .text,
      isEmpty,
    );
    await tester.pump(const Duration(milliseconds: 800));
    await tester.drag(find.byType(ListView).first, const Offset(0, -600));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.text('What is Java?'), findsOneWidget);
    expect(
      find.textContaining('tailor the next teaching step'),
      findsOneWidget,
    );
  });

  testWidgets('free-tier API key can be configured for this session', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AiTeacherScreen())),
    );
    await tester.pump(const Duration(milliseconds: 500));

    await tester.ensureVisible(find.text('Connect free AI'));
    await tester.tap(find.text('Connect free AI'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField).last, 'test-key');
    await tester.tap(find.text('Connect'));
    await tester.pump();

    expect(find.text('Groq key set'), findsOneWidget);
  });
}
