import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:flutter/material.dart';

Widget listViewTabBuilder(
  BuildContext context,
  ChampionTabController controller,
  List<TabDefinition> tabs,
) {
  final theme = Theme.of(context).colorScheme;
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemCount: tabs.length,
    itemBuilder: (BuildContext context, int index) {
      final isActive = index == controller.activeTab;

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color:
                  isActive ? theme.tertiaryContainer : theme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                tabs[index].name,
                style: TextStyle(
                  color:
                      isActive
                          ? theme.onPrimaryContainer
                          : theme.onSecondaryContainer,
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
