import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class HashtagTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  final Color hashtagColor;

  const HashtagTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.hashtagColor,
    this.maxLines = 1,
  });

  @override
  State<HashtagTextField> createState() => _HashtagTextFieldState();
}

class _HashtagTextFieldState extends State<HashtagTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false;

  static const TextStyle _textStyle = TextStyle(
    fontSize: 16,
    height: 1.4,
    color: AppColors.textPrimary,
    fontFamily: 'Roboto',
  );

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChanged);
    widget.controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChanged);
    widget.controller.removeListener(_onTextChanged);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  void _onTextChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.controller.text;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: _isFocused ? AppColors.primary : AppColors.divider,
            width: _isFocused ? 2 : 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // Highlighted text layer
                if (text.isEmpty)
                  Text(
                    widget.hintText,
                    style: _textStyle.copyWith(color: AppColors.textSecondary),
                  )
                else
                  SizedBox(
                    width: constraints.maxWidth,
                    child: _buildHighlightedText(),
                  ),
                SizedBox(
                  width: constraints.maxWidth,
                  child: EditableText(
                    controller: widget.controller,
                    focusNode: _focusNode,
                    style: _textStyle.copyWith(color: Colors.transparent),
                    cursorColor: AppColors.textPrimary,
                    backgroundCursorColor: Colors.grey,
                    maxLines: widget.maxLines,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHighlightedText() {
    final text = widget.controller.text;
    final RegExp hashtagRegex = RegExp(r'#\w+');
    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in hashtagRegex.allMatches(text)) {
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: _textStyle,
          ),
        );
      }
      spans.add(
        TextSpan(
          text: match.group(0),
          style: _textStyle.copyWith(
            color: widget.hashtagColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      lastIndex = match.end;
    }

    if (lastIndex < text.length) {
      spans.add(TextSpan(text: text.substring(lastIndex), style: _textStyle));
    }

    return RichText(
      text: TextSpan(children: spans),
      maxLines: widget.maxLines,
      softWrap: true,
    );
  }
}
