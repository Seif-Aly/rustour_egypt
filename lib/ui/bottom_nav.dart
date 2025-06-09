import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/ui_state_providers.dart';

class _Tab {
  const _Tab(this.label, this.icon, this.index);
  final String label;
  final IconData icon;
  final int index;
}

const _tabs = [
  _Tab('Главная', Icons.home_outlined, 0),
  _Tab('Исследовать', Icons.search_outlined, 1),
  _Tab('Профиль', Icons.person_outline, 2),
];

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tab = ref.watch(activeTabProvider);
    final theme = Theme.of(context);
    const pillColor = Color(0xFF11b57c);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              _tabs.map((t) {
                final bool isActive = t.index == tab;
                return Flexible(
                  child: GestureDetector(
                    onTap:
                        () =>
                            ref.read(activeTabProvider.notifier).state =
                                t.index,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: isActive ? 12 : 0,
                      ),
                      decoration: BoxDecoration(
                        color: isActive ? pillColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            t.icon,
                            size: 22,
                            color:
                                isActive ? Colors.white : Colors.grey.shade600,
                          ),
                          if (isActive) ...[
                            const SizedBox(width: 6),
                            Text(
                              t.label,
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
