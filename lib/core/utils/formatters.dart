String formatBytes(int bytes) {
  if (bytes < 1024) return '$bytes B';
  if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
  return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
}

String formatDuration(int ms) =>
    ms < 1000 ? '$ms ms' : '${(ms / 1000).toStringAsFixed(2)} s';

String formatTime(DateTime t) {
  final h = t.hour % 12 == 0 ? 12 : t.hour % 12;
  final m = t.minute.toString().padLeft(2, '0');
  return '$h:$m ${t.hour < 12 ? 'AM' : 'PM'}';
}

String formatDayLabel(DateTime t) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final day = DateTime(t.year, t.month, t.day);
  final diff = today.difference(day).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${months[t.month - 1]} ${t.day}, ${t.year}';
}

/// The last path segment-ish label for a URL, used in compact list rows.
String shortUrl(String url) {
  final noScheme = url.replaceFirst(RegExp(r'^[a-zA-Z]+://'), '');
  final slash = noScheme.indexOf('/');
  return slash < 0 ? noScheme : noScheme.substring(slash);
}

String urlHost(String url) {
  final noScheme = url.replaceFirst(RegExp(r'^[a-zA-Z]+://'), '');
  final slash = noScheme.indexOf('/');
  return slash < 0 ? noScheme : noScheme.substring(0, slash);
}
