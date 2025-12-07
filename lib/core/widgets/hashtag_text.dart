import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class HashtagText extends StatelessWidget {
  final String text;
  final Color hashtagColor;

  const HashtagText({
    super.key,
    required this.text,
    required this.hashtagColor,
  });

  @override
  Widget build(BuildContext context) {
    final RegExp hashtagRegex = RegExp(r'#\w+');
    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in hashtagRegex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: const TextStyle(color: AppColors.textPrimary),
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: TextStyle(color: hashtagColor, fontWeight: FontWeight.bold),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastIndex),
          style: const TextStyle(color: AppColors.textPrimary),
        ),
      );
    }

    return RichText(text: TextSpan(children: spans));
  }
}
