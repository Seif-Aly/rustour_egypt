import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 0‑Home, 1‑Explore, 2‑Notifications, 3‑Profile
final activeTabProvider = StateProvider<int>((_) => 0);
