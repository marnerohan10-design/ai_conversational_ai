import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import 'demo_data.dart';

class ChatGptSdkTutorService implements AIService {
  ChatGptSdkTutorService({
    required String token,
    required String apiUrl,
    required String model,
  }) : _token = token,
       _apiUrl = apiUrl,
       _model = model;

  final String _token;
  final String _apiUrl;
  final String _model;
  OpenAI? _client;

  OpenAI get _openAI =>
      _client ??= OpenAI.instance.build(token: _token, apiUrl: _apiUrl);

  @override
  Future<String> diagnose(
    String studentQuestion, {
    List<ConversationMessage> history = const [],
  }) async {
    final messages = <Map<String, dynamic>>[
      {
        'role': 'system',
        'content':
            'You are a patient, encouraging tutor who can answer questions '
            'across school subjects and general learning topics. Respond to the '
            'student question directly, explain clearly in small steps, and adapt '
            'your depth to a Class 10 learner. For Mathematics questions, this '
            'demo learner is Amit; Quadratic Equations mastery is 42%, '
            'Factorisation mastery is 35%, and sign errors recur. Use that demo '
            'context only when relevant. Do not claim to have inspected real '
            'student records. Ask a short checking question when useful.',
      },
      ...history
          .take(10)
          .map(
            (message) => {
              'role': message.isStudent ? 'user' : 'assistant',
              'content': message.text,
            },
          ),
      {'role': 'user', 'content': studentQuestion},
    ];
    return _complete(messages);
  }

  @override
  Future<List<String>> suggestedPrompts() async => const [
    'I do not understand Quadratic Equations.',
    'Help me with Factorisation shortcuts.',
    'Why am I making sign mistakes?',
    'Give me a quick revision session.',
  ];

  @override
  Future<Map<String, dynamic>> buildTeachingContent(String action) async {
    final answer = await _complete([
      {
        'role': 'system',
        'content':
            'You are a patient tutor for a Class 10 learner. Teach the requested '
            'school subject accurately in small, clear steps. For Mathematics, '
            'use Factorisation and sign mistakes as context only when relevant. '
            'Do not claim demo learner metrics are real. Return a concise lesson '
            'title on the first line, then the lesson body on following lines.',
      },
      {
        'role': 'user',
        'content':
            'Create a lesson for the tutoring action "$action" about '
            'Factorisation as a prerequisite to Quadratic Equations.',
      },
    ]);
    final lines = answer.split('\n');
    final title = lines.firstWhere(
      (line) => line.trim().isNotEmpty,
      orElse: () => 'AI Tutor Lesson',
    );
    final body = answer.replaceFirst(title, '').trim();
    return {
      'title': title.replaceFirst(RegExp(r'^[#*\s]+'), ''),
      'body': body.isEmpty ? answer : body,
    };
  }

  Future<String> _complete(List<Map<String, dynamic>> messages) async {
    final request = ChatCompleteText(
      messages: messages,
      maxToken: 500,
      model: ChatModelFromValue(model: _model),
    );
    final response = await _openAI.onChatCompletion(request: request);
    if (response == null || response.choices.isEmpty) {
      throw StateError('The AI tutor returned an empty response.');
    }
    final content = response.choices.first.message?.content.trim();
    if (content == null || content.isEmpty) {
      throw StateError('The AI tutor returned an empty response.');
    }
    return content;
  }
}
