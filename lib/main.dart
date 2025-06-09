import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rustour_egypt/providers/data_providers.dart';
import 'ui/pages/login_page.dart';
import 'ui/main_layout.dart';
import 'models/user.dart'; // Make sure this exists and points to your User class

void main() => runApp(const ProviderScope(child: RusTourApp()));

class RusTourApp extends ConsumerWidget {
  const RusTourApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meState = ref.watch(meProvider);

    // Debug print current user state
    meState.when(
      data: (user) => print("✅ User data found: $user"),
      loading: () => print("⏳ Loading user..."),
      error: (e, _) => print("❌ Error loading user: $e"),
    );

    // Fallback: show login screen if not loaded yet or no user set
    final defaultScreen =
        meState.whenOrNull(data: (_) => const MainLayout()) ??
        const LoginPage();

    return MaterialApp(
      title: 'RusTour Egypt',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF11b57c),
        useMaterial3: true,
        fontFamily: 'SFPro',
      ),
      debugShowCheckedModeBanner: false,
      home: defaultScreen,
    );
  }
}
