import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:flutter/widgets.dart';

class TabChild extends StatelessWidget {
  const TabChild({super.key, required this.children, required this.controller});
  final List<TabDefinition> children;
  final ChampionTabController controller;

  @override
  Widget build(BuildContext context) {
    final activeTab = controller.activeTab;

    final activeTabWidget = children
        .asMap()
        .entries
        .firstWhere((x) => activeTab == x.key)
        .value
        .tabBuilder(context);
    return CustomAnimatedSwitcher(
      fadeType: FadeType.slide,
      child: activeTabWidget,
    );
  }
}
