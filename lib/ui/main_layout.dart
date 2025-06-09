import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/ui_state_providers.dart';
import 'pages/home_page.dart';
import 'pages/explore_page.dart';
import 'pages/profile_page.dart';
import 'bottom_nav.dart';

class MainLayout extends ConsumerWidget {
  const MainLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(activeTabProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: tab,
        children: const [HomePage(), ExplorePage(), ProfilePage()],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
