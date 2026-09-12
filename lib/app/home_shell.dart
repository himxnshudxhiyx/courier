import 'package:courier/app/home_tab_provider.dart';
import 'package:courier/features/collections/presentation/screens/collections_screen.dart';
import 'package:courier/features/environments/presentation/screens/environments_screen.dart';
import 'package:courier/features/history/presentation/screens/history_screen.dart';
import 'package:courier/features/request/presentation/screens/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(selectedHomeTabProvider);
    return Scaffold(
      body: IndexedStack(
        index: tab.index,
        children: const [RequestScreen(), HistoryScreen(), CollectionsScreen(), EnvironmentsScreen()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab.index,
        onDestinationSelected: (i) {
          FocusManager.instance.primaryFocus?.unfocus();
          ref.read(selectedHomeTabProvider.notifier).select(HomeTab.values[i]);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.send_outlined), selectedIcon: Icon(Icons.send), label: 'Request'),
          NavigationDestination(icon: Icon(Icons.history), label: 'History'),
          NavigationDestination(
              icon: Icon(Icons.folder_outlined), selectedIcon: Icon(Icons.folder), label: 'Collections'),
          NavigationDestination(
              icon: Icon(Icons.layers_outlined), selectedIcon: Icon(Icons.layers), label: 'Environments'),
        ],
      ),
    );
  }
}
