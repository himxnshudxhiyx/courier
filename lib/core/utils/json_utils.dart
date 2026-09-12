import 'dart:convert';

String? tryPrettyJson(String source) {
  try {
    return const JsonEncoder.withIndent('  ').convert(jsonDecode(source));
  } catch (_) {
    return null;
  }
}

bool isValidJson(String source) {
  try {
    jsonDecode(source);
    return true;
  } catch (_) {
    return false;
  }
}
