import 'package:courier/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

/// Above this size, syntax highlighting is skipped to keep layout fast.
const kMaxHighlightChars = 300000;

final _jsonToken = RegExp(
  r'("(?:\\.|[^"\\])*")(\s*:)?|\b(true|false|null)\b|(-?\b\d+(?:\.\d+)?(?:[eE][+-]?\d+)?\b)|([{}\[\],])',
);

class CodeView extends StatelessWidget {
  const CodeView({
    super.key,
    required this.text,
    this.json = false,
    this.search = '',
    this.wrap = true,
    this.padding = const EdgeInsets.fromLTRB(12, 8, 12, 24),
  });

  final String text;
  final bool json;
  final String search;
  final bool wrap;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    final palette = CodePalette.of(Theme.of(context).brightness);
    final content = SelectableText.rich(
      TextSpan(
        style: monoStyle(context, fontSize: 12.5),
        children: highlightCode(text, json: json, search: search, palette: palette),
      ),
    );
    if (wrap) {
      return SingleChildScrollView(padding: padding, child: SizedBox(width: double.infinity, child: content));
    }
    return SingleChildScrollView(
      padding: padding,
      child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: content),
    );
  }
}

int countMatches(String text, String query) {
  if (query.isEmpty) return 0;
  final haystack = text.toLowerCase();
  final needle = query.toLowerCase();
  var count = 0;
  for (var i = haystack.indexOf(needle); i >= 0; i = haystack.indexOf(needle, i + needle.length)) {
    count++;
  }
  return count;
}

List<TextSpan> highlightCode(
  String text, {
  required bool json,
  required String search,
  required CodePalette palette,
}) {
  final tokens = <(String, TextStyle?)>[];
  if (json && text.length <= kMaxHighlightChars) {
    var last = 0;
    for (final m in _jsonToken.allMatches(text)) {
      if (m.start > last) tokens.add((text.substring(last, m.start), null));
      if (m.group(1) != null) {
        final isKey = m.group(2) != null;
        tokens.add((m.group(1)!, TextStyle(color: isKey ? palette.key : palette.string)));
        if (isKey) tokens.add((m.group(2)!, TextStyle(color: palette.punctuation)));
      } else if (m.group(3) != null) {
        tokens.add((m.group(3)!, TextStyle(color: palette.literal)));
      } else if (m.group(4) != null) {
        tokens.add((m.group(4)!, TextStyle(color: palette.number)));
      } else {
        tokens.add((m.group(0)!, TextStyle(color: palette.punctuation)));
      }
      last = m.end;
    }
    if (last < text.length) tokens.add((text.substring(last), null));
  } else {
    tokens.add((text, null));
  }

  if (search.isEmpty) {
    return [for (final t in tokens) TextSpan(text: t.$1, style: t.$2)];
  }

  // Split tokens around search matches (matches spanning tokens aren't marked).
  final needle = search.toLowerCase();
  final matchStyle = TextStyle(backgroundColor: palette.match);
  final spans = <TextSpan>[];
  for (final (tokenText, style) in tokens) {
    final lower = tokenText.toLowerCase();
    var start = 0;
    for (var i = lower.indexOf(needle); i >= 0; i = lower.indexOf(needle, start)) {
      if (i > start) spans.add(TextSpan(text: tokenText.substring(start, i), style: style));
      spans.add(TextSpan(
        text: tokenText.substring(i, i + needle.length),
        style: style?.merge(matchStyle) ?? matchStyle,
      ));
      start = i + needle.length;
    }
    if (start < tokenText.length) spans.add(TextSpan(text: tokenText.substring(start), style: style));
  }
  return spans;
}
