import 'package:champion_tabs/builders/tabs/tab_list_builder.dart';
import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabParent extends StatefulWidget {
  const TabParent({
    super.key,
    required this.tabs,
    this.controller,
    this.tabBuilder = listViewTabBuilder,
  });

  final List<TabDefinition> tabs;
  final ChampionTabController? controller;
  final Function(
    BuildContext context,
    ChampionTabController controller,
    List<TabDefinition> tabs,
  )
  tabBuilder;

  @override
  State<TabParent> createState() => _TabParentState();
}

class _TabParentState extends State<TabParent> {
  late ChampionTabController _controller;
  @override
  void initState() {
    super.initState();

    // Add in a controller if we don't have one.
    _controller = widget.controller ?? ChampionTabController();
  }

  @override
  Widget build(BuildContext context) {
    return widget.tabBuilder(context, _controller, widget.tabs);
  }
}
