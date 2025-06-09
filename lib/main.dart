import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router.dart';

void main() => runApp(const ProviderScope(child: RusTourApp()));

class RusTourApp extends StatelessWidget {
  const RusTourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'RusTour Egypt',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF11b57c), // the green you used
        useMaterial3: true,
        fontFamily: 'SFPro', // optional, if you added a custom font
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
