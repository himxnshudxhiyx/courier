import 'package:courier/shared/domain/entities/api_request.dart';

/// Splits "https://host/path?a=1&b=2#frag" into base and raw query pairs
/// without decoding, so `{{variables}}` and typed text round-trip untouched.
({String base, List<(String, String)> pairs}) splitUrl(String url) {
  final q = url.indexOf('?');
  if (q < 0) return (base: url, pairs: const []);
  var query = url.substring(q + 1);
  final hash = query.indexOf('#');
  if (hash >= 0) query = query.substring(0, hash);
  final pairs = <(String, String)>[];
  for (final part in query.split('&')) {
    if (part.isEmpty) continue;
    final eq = part.indexOf('=');
    pairs.add(eq < 0 ? (part, '') : (part.substring(0, eq), part.substring(eq + 1)));
  }
  return (base: url.substring(0, q), pairs: pairs);
}

String buildUrl(String base, List<KeyValuePair> params) {
  final active = params.where((p) => p.isActive).toList();
  if (active.isEmpty) return base;
  return '$base?${active.map((p) => p.value.isEmpty ? p.key : '${p.key}=${p.value}').join('&')}';
}

/// Re-derives params from an edited URL. Row ids are reused by position so
/// the editor keeps focus, and disabled params (absent from the URL) survive.
List<KeyValuePair> paramsFromUrl(String url, List<KeyValuePair> previous) {
  final pairs = splitUrl(url).pairs;
  final enabledPrev = previous.where((p) => p.enabled).toList();
  return [
    for (var i = 0; i < pairs.length; i++)
      i < enabledPrev.length
          ? enabledPrev[i].copyWith(key: pairs[i].$1, value: pairs[i].$2)
          : KeyValuePair.create(key: pairs[i].$1, value: pairs[i].$2),
    ...previous.where((p) => !p.enabled),
  ];
}
