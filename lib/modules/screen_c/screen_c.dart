import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenC extends StatefulWidget {
  const ScreenC({super.key});

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _hashtagsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _phraseController.addListener(_onPhraseChanged);
  }

  @override
  void dispose() {
    _phraseController.removeListener(_onPhraseChanged);
    _phraseController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }

  void _onPhraseChanged() {
    final hashtags = _extractHashtags(_phraseController.text);
    _hashtagsController.text = hashtags.join(' ');
  }

  List<String> _extractHashtags(String text) {
    final RegExp hashtagRegex = RegExp(r'#\w+');
    return hashtagRegex.allMatches(text).map((m) => m.group(0)!).toList();
  }

  void _onSubmit() {
    final phrase = _phraseController.text;
    final hashtags = _hashtagsController.text;
    context.go('/screen-b', extra: {'phrase': phrase, 'hashtags': hashtags});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen C'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Phrase',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _HashtagTextField(
              controller: _phraseController,
              hintText: 'Enter your phrase with #hashtags',
              maxLines: 4,
            ),
            const SizedBox(height: 24),
            const Text(
              'Hashtags',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            _HashtagTextField(
              controller: _hashtagsController,
              hintText: 'Hashtags will appear here',
              maxLines: 2,
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _onSubmit, child: const Text('Submit')),
          ],
        ),
      ),
    );
  }
}

class _HashtagTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  const _HashtagTextField({
    required this.controller,
    required this.hintText,
    this.maxLines = 1,
  });

  @override
  State<_HashtagTextField> createState() => _HashtagTextFieldState();
}

class _HashtagTextFieldState extends State<_HashtagTextField> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Stack(
        children: [
          _buildHighlightedText(context),
          TextField(
            controller: widget.controller,
            maxLines: widget.maxLines,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
            style: const TextStyle(color: Colors.transparent),
            cursorColor: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget _buildHighlightedText(BuildContext context) {
    final text = widget.controller.text;
    if (text.isEmpty) {
      return const SizedBox.shrink();
    }

    final RegExp hashtagRegex = RegExp(r'#\w+');
    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in hashtagRegex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: const TextStyle(color: Colors.black),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: const TextStyle(color: Colors.black),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
