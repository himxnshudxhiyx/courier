import 'package:courier/app/app.dart';
import 'package:courier/core/storage/hive_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveStorage();
  runApp(const ProviderScope(child: CourierApp()));
}
