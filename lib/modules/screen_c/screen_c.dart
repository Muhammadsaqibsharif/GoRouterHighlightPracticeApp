import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/widgets.dart';

class ScreenC extends StatefulWidget {
  const ScreenC({super.key});

  @override
  State<ScreenC> createState() => _ScreenCState();
}

class _ScreenCState extends State<ScreenC> {
  final TextEditingController _phraseController = TextEditingController();
  final TextEditingController _hashtagsController = TextEditingController();
  Set<String> _manuallyAddedHashtags = {};
  Set<String> _lastExtractedHashtags = {};

  @override
  void initState() {
    super.initState();
    _phraseController.addListener(_onPhraseChanged);
    _hashtagsController.addListener(_onHashtagsManuallyChanged);
  }

  @override
  void dispose() {
    _phraseController.removeListener(_onPhraseChanged);
    _hashtagsController.removeListener(_onHashtagsManuallyChanged);
    _phraseController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }

  void _onPhraseChanged() {
    final extractedHashtags = _extractHashtags(_phraseController.text).toSet();

    final allHashtags = <String>{
      ...extractedHashtags,
      ..._manuallyAddedHashtags,
    };

    _manuallyAddedHashtags = _manuallyAddedHashtags.difference(
      _lastExtractedHashtags.difference(extractedHashtags),
    );

    _lastExtractedHashtags = extractedHashtags;

    final newHashtagsText = allHashtags.join(' ');
    if (_hashtagsController.text != newHashtagsText) {
      _hashtagsController.text = newHashtagsText;
    }
  }

  void _onHashtagsManuallyChanged() {
    final currentHashtags = _extractHashtags(_hashtagsController.text).toSet();
    final extractedFromPhrase = _extractHashtags(
      _phraseController.text,
    ).toSet();
    _manuallyAddedHashtags = currentHashtags.difference(extractedFromPhrase);
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
      appBar: AppBar(title: const Text('Screen C')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GradientCard(
                title: 'Phrase',
                icon: Icons.format_quote,
                headerGradient: AppGradients.primaryGradient,
                child: HashtagTextField(
                  controller: _phraseController,
                  hintText: 'Enter your phrase with #hashtags',
                  maxLines: 4,
                  hashtagColor: AppColors.hashtagPhrase,
                ),
              ),
              const SizedBox(height: 16),
              GradientCard(
                title: 'Hashtags',
                icon: Icons.tag,
                headerGradient: AppGradients.accentGradient,
                child: HashtagTextField(
                  controller: _hashtagsController,
                  hintText: 'Hashtags will appear here',
                  maxLines: 2,
                  hashtagColor: AppColors.hashtagField,
                ),
              ),
              const SizedBox(height: 24),
              GradientButton(
                onPressed: _onSubmit,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.send_rounded),
                    SizedBox(width: 8),
                    Text('Submit'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
