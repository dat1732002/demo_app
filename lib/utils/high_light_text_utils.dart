import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HighlightTextBase extends StatefulWidget {
  final String text;
  final TextStyle? normalStyle;
  final TextStyle? highlightStyle;
  final int characterLimit;

  const HighlightTextBase({
    super.key,
    required this.text,
    this.normalStyle,
    this.highlightStyle,
    this.characterLimit = 150,
  });

  @override
  State<HighlightTextBase> createState() => _HighlightTextBaseState();
}

class _HighlightTextBaseState extends State<HighlightTextBase> {
  bool isExpanded = false;
  Timer? _debounce;

  @override
  Widget build(BuildContext context) {
    final isTextOverflowing = widget.text.length > widget.characterLimit;

    final displayText = isExpanded
        ? widget.text
        : (isTextOverflowing
        ? '${widget.text.substring(0, widget.characterLimit)}...'
        : widget.text);

    return GestureDetector(
      onTap: () {
        if (isTextOverflowing) {
          setState(() {
            isExpanded = !isExpanded;
          });
        }
      },
      child: RichText(
        text: _buildTextWithHashtags(displayText, isTextOverflowing),
      ),
    );
  }

  void _onHashtagTap(String hashtag) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () {
      debugPrint('Bạn đã nhấn vào hashtag: $hashtag');
    });
  }

  TextSpan _buildTextWithHashtags(String displayText, bool isTextOverflowing) {
    final hashtagRegex = RegExp(r'(#[a-zA-Z0-9_]+)');
    final List<TextSpan> spans = [];

    displayText.splitMapJoin(
      hashtagRegex,
      onMatch: (match) {
        final hashtag = match.group(0)!;
        spans.add(
          TextSpan(
            text: hashtag,
            style: widget.highlightStyle ??
                TextStyle(fontSize: 16,color: Colors.blueAccent),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                _onHashtagTap(hashtag);
              },
          ),
        );
        return match.group(0)!;
      },
      onNonMatch: (nonMatch) {
        spans.add(
          TextSpan(
            text: nonMatch,
            style: widget.normalStyle ??
                const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
          ),
        );
        return nonMatch;
      },
    );

    // Thêm "See more" / "See less"
    if (isTextOverflowing) {
      spans.add(
        TextSpan(
          text: isExpanded ? ' See less' : ' See more',
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
        ),
      );
    }

    return TextSpan(children: spans);
  }
}
