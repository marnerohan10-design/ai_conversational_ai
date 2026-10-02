import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../data/demo_data.dart';
import '../data/openai_tutor_service.dart';
import '../widgets/common_widgets.dart';

class AiTeacherScreen extends StatefulWidget {
  const AiTeacherScreen({super.key});

  @override
  State<AiTeacherScreen> createState() => _AiTeacherScreenState();
}

class _AiTeacherScreenState extends State<AiTeacherScreen>
    with TickerProviderStateMixin {
  static const _openAiApiKey = String.fromEnvironment('OPENAI_API_KEY');
  static const _freeApiBaseUrl = 'https://api.groq.com/openai/v1';
  static const _freeApiModel = 'openai/gpt-oss-120b';

  final TextEditingController _controller = TextEditingController();
  final TextEditingController _apiKeyController = TextEditingController();
  final ScrollController _conversationScrollController = ScrollController();
  final List<ConversationMessage> _messages = List.from(
    DemoData.teacherConversation,
  );
  String _currentAction = 'Explain';
  AIService _aiService = DemoAIService();
  String _providerLabel = 'Demo mode';
  late Future<Map<String, dynamic>> _teachingContent;
  bool _isProcessing = false;
  late final AnimationController _pulseController;
  late final AnimationController _orbitController;

  @override
  void initState() {
    super.initState();
    if (_openAiApiKey.isNotEmpty) {
      _aiService = ChatGptSdkTutorService(
        token: _openAiApiKey,
        apiUrl: 'https://api.openai.com/v1',
        model: 'gpt-4o-mini',
      );
      _providerLabel = 'OpenAI';
    }
    _teachingContent = DemoAIService().buildTeachingContent(_currentAction);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _orbitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();
  }

  void _selectAction(String action) {
    setState(() {
      _currentAction = action;
      _teachingContent = _aiService.buildTeachingContent(action);
    });
  }

  void _retryTeachingContent() {
    setState(() {
      _teachingContent = _aiService.buildTeachingContent(_currentAction);
    });
  }

  Future<void> _configureFreeAi() async {
    _apiKeyController.clear();
    final apiKey = await showDialog<String>(
      context: context,
      builder:
          (dialogContext) => AlertDialog(
            scrollable: true,
            title: const Text('Connect free-tier AI'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create your own GroqCloud API key. Free usage is subject to '
                  'Groq account limits and may change.',
                ),
                const SizedBox(height: 12),
                SelectableText(
                  'console.groq.com/keys',
                  style: TextStyle(
                    color: Theme.of(dialogContext).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _apiKeyController,
                  autofocus: true,
                  obscureText: true,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    labelText: 'Groq API key',
                    hintText: 'Paste your key',
                    prefixIcon: Icon(Icons.key_rounded),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Kept in memory only for this app session. Never share your key '
                  'or publish a build containing it.',
                  style: TextStyle(fontSize: 12, color: AppTheme.muted),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () {
                  final key = _apiKeyController.text.trim();
                  if (key.isEmpty) {
                    return;
                  }
                  Navigator.pop(dialogContext, key);
                },
                child: const Text('Connect'),
              ),
            ],
          ),
    );
    _apiKeyController.clear();
    if (!mounted || apiKey == null) {
      return;
    }
    setState(() {
      _aiService = ChatGptSdkTutorService(
        token: apiKey,
        apiUrl: _freeApiBaseUrl,
        model: _freeApiModel,
      );
      _providerLabel = 'Groq key set';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Key added for this session. Ask the tutor a question.'),
      ),
    );
  }

  void _disconnectAi() {
    setState(() {
      _aiService = DemoAIService();
      _providerLabel = 'Demo mode';
      _teachingContent = _aiService.buildTeachingContent(_currentAction);
    });
  }

  void _scrollConversationToLatest() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_conversationScrollController.hasClients) {
        _conversationScrollController.animateTo(
          _conversationScrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _apiKeyController.dispose();
    _conversationScrollController.dispose();
    _pulseController.dispose();
    _orbitController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final message = _controller.text.trim();
    if (message.isEmpty) {
      return;
    }

    final history = List<ConversationMessage>.of(_messages);
    setState(() {
      _messages.add(ConversationMessage(isStudent: true, text: message));
      _isProcessing = true;
    });
    _scrollConversationToLatest();
    _controller.clear();

    try {
      final aiReply = await _aiService.diagnose(message, history: history);

      if (!mounted) {
        return;
      }

      setState(() {
        _messages.add(
          ConversationMessage(
            isStudent: false,
            text: aiReply,
            chips: const ['AI TUTOR'],
          ),
        );
      });
      _scrollConversationToLatest();
    } catch (error) {
      debugPrint('AI tutor request failed (${error.runtimeType}).');
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The AI tutor could not respond. Check your connection, API key, and provider limits.',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  void _askSuggestedQuestion(String question) {
    if (_isProcessing) {
      return;
    }
    _controller.text = question;
    _sendMessage();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 980;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child:
            isDesktop
                ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: _buildConversationPanel()),
                    const SizedBox(width: 18),
                    Expanded(flex: 4, child: _buildTeachingPanel()),
                    const SizedBox(width: 18),
                    Expanded(flex: 2, child: _buildContextPanel()),
                  ],
                )
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 520, child: _buildConversationPanel()),
                      const SizedBox(height: 18),
                      _buildTeachingPanel(),
                      const SizedBox(height: 18),
                      _buildContextPanel(),
                    ],
                  ),
                ),
      ),
    );
  }

  Widget _buildConversationPanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'AI TEACHER',
            subtitle: 'Ask a question about any subject',
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Wrap(
              alignment: WrapAlignment.end,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 8,
              children: [
                Chip(
                  avatar: Icon(
                    _providerLabel == 'Demo mode'
                        ? Icons.smart_toy_outlined
                        : Icons.cloud_done_rounded,
                    size: 18,
                  ),
                  label: Text(_providerLabel),
                ),
                if (_providerLabel == 'Demo mode')
                  OutlinedButton.icon(
                    onPressed: _configureFreeAi,
                    icon: const Icon(Icons.key_rounded),
                    label: const Text('Connect free AI'),
                  )
                else
                  PopupMenuButton<String>(
                    tooltip: 'AI connection settings',
                    onSelected: (value) {
                      if (value == 'connect') {
                        _configureFreeAi();
                      } else {
                        _disconnectAi();
                      }
                    },
                    itemBuilder:
                        (context) => [
                          const PopupMenuItem(
                            value: 'connect',
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.key_rounded),
                              title: Text('Change API key'),
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'disconnect',
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.link_off_rounded),
                              title: Text('Disconnect AI'),
                            ),
                          ),
                        ],
                  ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              controller: _conversationScrollController,
              padding: EdgeInsets.zero,
              itemCount: _messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isStudent = message.isStudent;
                return Align(
                  alignment:
                      isStudent ? Alignment.centerRight : Alignment.centerLeft,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color:
                            isStudent
                                ? AppTheme.royalBlue
                                : const Color(0xFFF3F4F6),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isStudent ? 'Amit' : 'AI Teacher',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: isStudent ? Colors.white : AppTheme.navy,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            message.text,
                            style: TextStyle(
                              color: isStudent ? Colors.white : AppTheme.navy,
                              height: 1.5,
                            ),
                          ),
                          if (message.chips != null) ...[
                            const SizedBox(height: 10),
                            Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children:
                                  message.chips!
                                      .map(
                                        (chip) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 5,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                isStudent
                                                    ? Colors.white.withValues(
                                                      alpha: 0.12,
                                                    )
                                                    : AppTheme.royalBlue
                                                        .withValues(
                                                          alpha: 0.08,
                                                        ),
                                            borderRadius: BorderRadius.circular(
                                              999,
                                            ),
                                          ),
                                          child: Text(
                                            chip,
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w800,
                                              letterSpacing: 0.7,
                                              color:
                                                  isStudent
                                                      ? Colors.white
                                                      : AppTheme.royalBlue,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_messages.length <= DemoData.teacherConversation.length)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _SuggestedQuestionChip(
                    label: 'Explain photosynthesis',
                    onPressed:
                        () => _askSuggestedQuestion(
                          'Explain photosynthesis simply.',
                        ),
                  ),
                  const SizedBox(width: 8),
                  _SuggestedQuestionChip(
                    label: 'Solve a maths question',
                    onPressed:
                        () => _askSuggestedQuestion(
                          'How do I solve x² + 5x + 6 = 0?',
                        ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const ValueKey('tutor-question-input'),
                  controller: _controller,
                  minLines: 1,
                  maxLines: 3,
                  textInputAction: TextInputAction.send,
                  onSubmitted: (_) {
                    if (!_isProcessing) {
                      _sendMessage();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'Ask the AI Teacher...',
                    prefixIcon: const Icon(Icons.chat_bubble_outline_rounded),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              FilledButton(
                onPressed: _isProcessing ? null : _sendMessage,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(50, 56),
                  backgroundColor: AppTheme.royalBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Tooltip(
                  message: 'Send question',
                  child: Icon(Icons.send_rounded),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTeachingPanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'AI TEACHING CONTENT',
            subtitle: 'Adaptive and student-aware',
          ),
          const SizedBox(height: 8),
          AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final pulse = 0.92 + (_pulseController.value * 0.12);
              return Transform.scale(
                scale: pulse,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFE8F0FF), Color(0xFFE9FBFF)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      AnimatedBuilder(
                        animation: _orbitController,
                        builder: (context, child) {
                          final angle =
                              _orbitController.value * 2 * 3.1415926535;
                          return SizedBox(
                            width: 74,
                            height: 74,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Transform.rotate(
                                  angle: angle,
                                  child: Container(
                                    width: 66,
                                    height: 66,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppTheme.royalBlue.withValues(
                                          alpha: 0.28,
                                        ),
                                        width: 2,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        AppTheme.royalBlue,
                                        AppTheme.cyan,
                                      ],
                                    ),
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.royalBlue.withValues(
                                          alpha: 0.25,
                                        ),
                                        blurRadius: 18,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.smart_toy_rounded,
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'AI Tutor',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.navy,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Teaching Factorisation before Quadratic Equations',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppTheme.muted,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 18),
          FutureBuilder<Map<String, dynamic>>(
            future: _teachingContent,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'The tutor could not load this lesson.',
                      style: TextStyle(color: AppTheme.red),
                    ),
                    TextButton(
                      onPressed: _retryTeachingContent,
                      child: const Text('Try again'),
                    ),
                  ],
                );
              }
              if (!snapshot.hasData) {
                return const LinearProgressIndicator();
              }
              final data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title'] as String,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F6FF),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      data['body'] as String,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        height: 1.7,
                        color: AppTheme.navy,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _ActionChip(
                label: 'Explain',
                isActive: _currentAction == 'Explain',
                onTap: () => _selectAction('Explain'),
              ),
              _ActionChip(
                label: 'Show Example',
                isActive: _currentAction == 'Show Example',
                onTap: () => _selectAction('Show Example'),
              ),
              _ActionChip(
                label: 'Give Hint',
                isActive: _currentAction == 'Give Hint',
                onTap: () => _selectAction('Give Hint'),
              ),
              _ActionChip(
                label: 'Practice',
                isActive: _currentAction == 'Practice',
                onTap: () => _selectAction('Practice'),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'LEARNING DIAGNOSIS',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.8,
                    color: AppTheme.muted,
                  ),
                ),
                const SizedBox(height: 12),
                RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: AppTheme.navy,
                      fontSize: 15,
                      height: 1.6,
                    ),
                    children: [
                      TextSpan(
                        text: 'Quadratic Equations\n',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: '42% mastery\n\n'),
                      TextSpan(
                        text: 'Prerequisite:\n',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(text: 'Factorisation\n35% mastery\n\n'),
                      TextSpan(
                        text: 'Status: ',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      TextSpan(
                        text: 'ROOT LEARNING GAP DETECTED',
                        style: TextStyle(color: AppTheme.red),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContextPanel() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'STUDENT CONTEXT',
            subtitle: 'Current learner model',
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F7FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) {
                    return Transform.scale(
                      scale: 0.96 + (_pulseController.value * 0.1),
                      child: Container(
                        width: 62,
                        height: 62,
                        decoration: BoxDecoration(
                          color: AppTheme.lavender.withValues(alpha: 0.14),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.lavender.withValues(alpha: 0.18),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.person,
                          color: AppTheme.lavender,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                const Text(
                  'Amit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppTheme.navy,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Class 10 • Mathematics',
                  style: TextStyle(
                    color: AppTheme.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _ContextMetric(label: 'Learning style', value: 'Step-by-step'),
          _ContextMetric(label: 'Preferred language', value: 'English'),
          _ContextMetric(label: 'Voice', value: 'Enabled'),
          _ContextMetric(label: 'Learning pace', value: 'Moderate'),
          const SizedBox(height: 18),
          const Text(
            'AI AVATAR',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              color: AppTheme.muted,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F6FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, _) {
                    return Transform.scale(
                      scale: 1 + (_pulseController.value * 0.18),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [AppTheme.royalBlue, AppTheme.cyan],
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: AppTheme.royalBlue.withValues(alpha: 0.22),
                              blurRadius: 18,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.smart_toy_rounded,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'LISTENING',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppTheme.navy,
                        ),
                      ),
                      Text(
                        'Explaining • Encouraging • Checking progress',
                        style: TextStyle(color: AppTheme.muted),
                      ),
                    ],
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

class _ActionChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isActive ? AppTheme.royalBlue : const Color(0xFFF3F4F6),
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: isActive ? Colors.white : AppTheme.navy,
            ),
          ),
        ),
      ),
    );
  }
}

class _SuggestedQuestionChip extends StatelessWidget {
  const _SuggestedQuestionChip({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      avatar: const Icon(Icons.auto_awesome_rounded, size: 16),
      label: Text(label),
      onPressed: onPressed,
      backgroundColor: const Color(0xFFEFF4FF),
      side: BorderSide.none,
      labelStyle: const TextStyle(
        color: AppTheme.navy,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

class _ContextMetric extends StatelessWidget {
  final String label;
  final String value;

  const _ContextMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppTheme.muted,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontWeight: FontWeight.w800,
                color: AppTheme.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
