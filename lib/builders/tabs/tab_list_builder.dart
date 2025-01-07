import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:flutter/material.dart';

Widget listViewTabBuilder(
  BuildContext context,
  ChampionTabController controller,
  List<TabDefinition> tabs,
) {
  final theme = Theme.of(context).colorScheme;

  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children:
          tabs.asMap().entries.map((entry) {
            final index = entry.key;
            final tab = entry.value;
            final isActive = index == controller.activeTab;

            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => controller.changeTab(index),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  margin: const EdgeInsets.only(right: 8),
                  decoration: BoxDecoration(
                    color: isActive ? theme.primary : theme.tertiary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      tab.name,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: isActive ? theme.onPrimary : theme.onPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
    ),
  );
}
