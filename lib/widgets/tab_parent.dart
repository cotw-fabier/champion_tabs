import 'package:champion_tabs/builders/tabs/tab_list_builder.dart';
import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TabParent extends StatefulWidget {
  const TabParent({
    super.key,
    required this.tabs,
    required this.controller,
    this.tabBuilder = listViewTabBuilder,
  });

  final List<TabDefinition> tabs;
  final ChampionTabController controller;
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
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return widget.tabBuilder(context, widget.controller, widget.tabs);
  }
}
