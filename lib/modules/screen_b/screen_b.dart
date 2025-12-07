import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/widgets.dart';

class ScreenB extends StatelessWidget {
  final String? phrase;
  final String? hashtags;

  const ScreenB({super.key, this.phrase, this.hashtags});

  @override
  Widget build(BuildContext context) {
    final bool hasData = phrase != null && phrase!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('Screen B')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.backgroundGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (hasData) ...[
                GradientCard(
                  title: 'Phrase',
                  icon: Icons.format_quote,
                  headerGradient: AppGradients.primaryGradient,
                  child: HashtagText(
                    text: phrase!,
                    hashtagColor: AppColors.hashtagPhrase,
                  ),
                ),
                const SizedBox(height: 16),
                GradientCard(
                  title: 'Hashtags',
                  icon: Icons.tag,
                  headerGradient: AppGradients.accentGradient,
                  child: HashtagText(
                    text: hashtags ?? '',
                    hashtagColor: AppColors.hashtagField,
                  ),
                ),
                const SizedBox(height: 24),
                GradientButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  gradient: AppGradients.primaryGradient,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.celebration,
                                  color: AppColors.onPrimary,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text('Congratulations 🎉'),
                            ],
                          ),
                          content: const Text('You have completed the task!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(dialogContext).pop();
                                context.go('/');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle_outline),
                      SizedBox(width: 8),
                      Text('Done'),
                    ],
                  ),
                ),
              ] else ...[
                Center(
                  child: Column(
                    children: [
                      const GradientIconBox(
                        icon: Icons.edit_note_rounded,
                        gradient: AppGradients.accentGradient,
                      ),
                      const SizedBox(height: 32),
                      Text(
                        'Ready to create?',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Add your phrase and hashtags',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                        onPressed: () => context.go('/screen-b/screen-c'),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Go to Screen C'),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
