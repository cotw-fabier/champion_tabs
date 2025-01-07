import 'package:flutter/widgets.dart';

class TabDefinition {
  final String name;
  final WidgetBuilder tabBuilder;
  const TabDefinition({required this.name, required this.tabBuilder});
}
