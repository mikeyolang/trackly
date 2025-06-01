import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackly/presentation/pages/visits_list_page.dart';
import 'package:trackly/presentation/pages/statistics_page.dart';
import 'package:trackly/presentation/widgets/bottom_navigation.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [VisitsListPage(), StatisticsPage()],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
