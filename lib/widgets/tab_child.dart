import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/fade_type.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:champion_tabs/widgets/animations/custom_animated_switcher.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';

class TabChild extends StatefulWidget {
  const TabChild({
    super.key,
    required this.children,
    required this.controller,
    this.animationWrapper,
  });

  /// Instead of a `Widget?`, define a callback
  /// that takes the child and returns a Widget.
  final Widget Function(Widget child)? animationWrapper;

  final List<TabDefinition> children;
  final ChampionTabController controller;

  @override
  State<TabChild> createState() => _TabChildState();
}

class _TabChildState extends State<TabChild> {
  @override
  Widget build(BuildContext context) {
    final activeTab = widget.controller.activeTab;

    // Build the "inner" active tab widget
    final activeTabWidget =
        widget.children
            .asMap()
            .entries
            .firstWhereOrNull((x) => activeTab == x.key)
            ?.value
            .tabBuilder(context) ??
        // If we're on an invalid tab, provide some feedback'
        const Center(child: Text("Invalid Tab Selection"));

    // If `animationWrapper` is provided, use it to wrap `activeTabWidget`.
    // Otherwise, use a default CustomAnimatedSwitcher as your wrapper.
    if (widget.animationWrapper != null) {
      return widget.animationWrapper!(activeTabWidget);
    } else {
      return CustomAnimatedSwitcher(
        fadeType: FadeType.slide,
        child: activeTabWidget,
      );
    }
  }
}
