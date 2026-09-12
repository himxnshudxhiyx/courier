import 'dart:math';

final _random = Random();

String generateId() =>
    '${DateTime.now().microsecondsSinceEpoch.toRadixString(36)}'
    '${_random.nextInt(1 << 32).toRadixString(36)}';
