class StudentProfile {
  final String name;
  final int classLevel;
  final String subject;
  final List<String> subjects;
  final List<MasteryMetric> mastery;
  final String preferredLanguage;
  final String learningStyle;
  final bool voiceEnabled;
  final String learningPace;
  final String recurringMistake;

  const StudentProfile({
    required this.name,
    required this.classLevel,
    required this.subject,
    required this.subjects,
    required this.mastery,
    required this.preferredLanguage,
    required this.learningStyle,
    required this.voiceEnabled,
    required this.learningPace,
    required this.recurringMistake,
  });
}

class MasteryMetric {
  final String title;
  final double mastery;
  final String status;
  final int attempts;
  final double accuracy;

  const MasteryMetric({
    required this.title,
    required this.mastery,
    required this.status,
    required this.attempts,
    required this.accuracy,
  });
}

class ConversationMessage {
  final bool isStudent;
  final String text;
  final List<String>? chips;

  const ConversationMessage({
    required this.isStudent,
    required this.text,
    this.chips,
  });
}

class PracticeQuestion {
  final String prompt;
  final String topic;
  final String difficulty;
  final String answer;
  final String hint;
  final String explanation;

  const PracticeQuestion({
    required this.prompt,
    required this.topic,
    required this.difficulty,
    required this.answer,
    required this.hint,
    required this.explanation,
  });
}

class MistakeEntry {
  final String topic;
  final String question;
  final String studentAnswer;
  final String correctAnswer;
  final String reason;
  final String category;

  const MistakeEntry({
    required this.topic,
    required this.question,
    required this.studentAnswer,
    required this.correctAnswer,
    required this.reason,
    required this.category,
  });
}

abstract class AIService {
  Future<String> diagnose(
    String studentQuestion, {
    List<ConversationMessage> history = const [],
  });
  Future<List<String>> suggestedPrompts();
  Future<Map<String, dynamic>> buildTeachingContent(String action);
}

abstract class RagService {
  Future<List<String>> findSources(String concept);
  Future<String> safeReasoningSummary(String concept);
}

class DemoAIService implements AIService {
  @override
  Future<String> diagnose(
    String studentQuestion, {
    List<ConversationMessage> history = const [],
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 700));
    if (studentQuestion.toLowerCase().contains('quadratic')) {
      return 'I can help. Before we start, I noticed that Factorisation is an important prerequisite for this topic, and your recent practice suggests you may need a quick revision.';
    }
    return 'Let me understand your learning gap and tailor the next teaching step around your weak prerequisite.';
  }

  @override
  Future<List<String>> suggestedPrompts() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      'I do not understand Quadratic Equations.',
      'Help me with Factorisation shortcuts.',
      'Why am I making sign mistakes?',
      'Give me a quick revision session.',
    ];
  }

  @override
  Future<Map<String, dynamic>> buildTeachingContent(String action) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    switch (action) {
      case 'Explain':
        return {
          'title': 'Factorisation Fundamentals',
          'body':
              'Factorisation splits a polynomial into simpler expressions. For xÂ² + 5x + 6, we need two numbers whose product is 6 and sum is 5. Those numbers are 2 and 3, so the expression becomes (x + 2)(x + 3).',
        };
      case 'Show Example':
        return {
          'title': 'Worked Example',
          'body': 'xÂ² + 5x + 6 = 0\nFind two numbers with product 6 and sum 5\nThe numbers are 2 and 3\nAnswer: (x + 2)(x + 3)',
        };
      case 'Give Hint':
        return {
          'title': 'Hint',
          'body': 'Look for factor pairs of the constant term and check which pair adds to the middle coefficient.',
        };
      case 'Practice':
        return {
          'title': 'Quick Check',
          'body': 'Solve: xÂ² + 7x + 12. Which pair multiplies to 12 and adds to 7?',
        };
      default:
        return {
          'title': 'Adaptive tutoring',
          'body': 'I will align the next step to the exact misconception you are showing.',
        };
    }
  }
}

class DemoRagService implements RagService {
  @override
  Future<List<String>> findSources(String concept) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return [
      'Curriculum: Algebra essentials',
      'Class notes: Factorisation patterns',
      'Practice workbook: Quadratic prerequisites',
    ];
  }

  @override
  Future<String> safeReasoningSummary(String concept) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    if (concept.toLowerCase().contains('factorisation') || concept.toLowerCase().contains('factorization')) {
      return 'Selected because Factorisation is a prerequisite for your current topic and your recent mastery is below the recommended threshold.';
    }
    return 'Selected because this concept is the closest concept to your current learning goal and matches your recent practice pattern.';
  }
}

class DemoData {
  static const StudentProfile studentProfile = StudentProfile(
    name: 'Amit',
    classLevel: 10,
    subject: 'Mathematics',
    subjects: ['Mathematics', 'Science', 'English'],
    mastery: [
      MasteryMetric(
        title: 'Quadratic Equations',
        mastery: 42,
        status: 'Learning',
        attempts: 18,
        accuracy: 58,
      ),
      MasteryMetric(
        title: 'Factorisation',
        mastery: 35,
        status: 'Weak',
        attempts: 21,
        accuracy: 49,
      ),
      MasteryMetric(
        title: 'Algebra Basics',
        mastery: 72,
        status: 'Mastered',
        attempts: 33,
        accuracy: 79,
      ),
    ],
    preferredLanguage: 'English',
    learningStyle: 'Step-by-step',
    voiceEnabled: true,
    learningPace: 'Moderate',
    recurringMistake: 'Sign errors',
  );

  static const List<ConversationMessage> teacherConversation = [
    ConversationMessage(
      isStudent: true,
      text: "I don't understand Quadratic Equations.",
    ),
    ConversationMessage(
      isStudent: false,
      text:
          'I can help. Before we start, I noticed that Factorisation is an important prerequisite for this topic, and your recent practice suggests you may need a quick revision.',
      chips: ['LEARNING DIAGNOSIS', 'ROOT LEARNING GAP DETECTED'],
    ),
  ];

  static const List<PracticeQuestion> practiceQuestions = [
    PracticeQuestion(
      prompt: 'Factorise: xÂ² + 5x + 6',
      topic: 'Factorisation',
      difficulty: 'Easy',
      answer: '(x+2)(x+3)',
      hint: 'Find two numbers whose product is 6 and sum is 5.',
      explanation:
          'We need numbers 2 and 3 because 2 Ã— 3 = 6 and 2 + 3 = 5. Therefore xÂ² + 5x + 6 = (x + 2)(x + 3).',
    ),
    PracticeQuestion(
      prompt: 'Solve: xÂ² + 7x + 12 = 0',
      topic: 'Factorisation',
      difficulty: 'Medium',
      answer: 'x=-3 or x=-4',
      hint: 'Look for a pair that gives 12 and adds to 7.',
      explanation:
          'Since 3 Ã— 4 = 12 and 3 + 4 = 7, we factor as (x + 3)(x + 4) = 0. The roots are x = -3 and x = -4.',
    ),
  ];

  static const List<MistakeEntry> mistakes = [
    MistakeEntry(
      topic: 'Factorisation',
      question: 'xÂ² + 5x + 6',
      studentAnswer: '(x - 2)(x - 3)',
      correctAnswer: '(x + 2)(x + 3)',
      reason: 'You sign-handled the constant terms incorrectly while selecting the factor pair.',
      category: 'Sign Error',
    ),
    MistakeEntry(
      topic: 'Quadratic Equations',
      question: 'xÂ² - 4 = 0',
      studentAnswer: 'x = 4',
      correctAnswer: 'x = Â±2',
      reason: 'The equation needs a square root step after isolating xÂ².',
      category: 'Concept Gap',
    ),
    MistakeEntry(
      topic: 'Algebra',
      question: 'Expand (x + 3)(x + 2)',
      studentAnswer: 'xÂ² + 5x + 4',
      correctAnswer: 'xÂ² + 5x + 6',
      reason: 'The constant term was miscalculated during expansion.',
      category: 'Calculation Error',
    ),
  ];

  static const List<String> journeyStages = [
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
}
