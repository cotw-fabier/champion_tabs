import 'package:champion_tabs/controllers/tab_controller.dart';
import 'package:champion_tabs/models/tab_definition.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TabChild extends StatefulWidget {
  const TabChild({
    super.key,
    required this.children,
    required this.controller,
    this.transitionDuration,
    this.animationWrapper,
  });

  /// Instead of a `Widget?`, define a callback
  /// that takes the child and returns a Widget.
  final Widget Function(Widget child)? animationWrapper;

  final List<TabDefinition> children;
  final ChampionTabController controller;
  final Duration? transitionDuration;

  @override
  State<TabChild> createState() => _TabChildState();
}

class _TabChildState extends State<TabChild> {
  late int _lastTab;
  late int _thisTab;
  late Widget _currentChild;
  late Widget _animatedChild;
  late Duration _duration;
  @override
  void initState() {
    super.initState();

    _duration = widget.transitionDuration ?? Duration(milliseconds: 150);
    _lastTab = widget.controller.activeTab;
    _thisTab = widget.controller.activeTab;
    _currentChild = _grabTab(widget.controller.activeTab);
    _animatedChild = _currentChild;
    widget.controller.addListener(_updateTab);
  }

  void _updateTab() {
    setState(() {
      _lastTab = _thisTab;
      _thisTab = widget.controller.activeTab;
      _animateChildSwap();
    });
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(_updateTab);
  }

  Widget _grabTab(int index) {
    return widget.children
            .asMap()
            .entries
            .firstWhereOrNull((x) => index == x.key)
            ?.value
            .tabBuilder(context) ??
        // If we're on an invalid tab, provide some feedback'
        const Center(child: Text("Invalid Tab Selection"));
  }

  @override
  void didUpdateWidget(covariant TabChild oldWidget) {
    if (widget.controller.activeTab != _lastTab) {
      _animateChildSwap();
    }
    super.didUpdateWidget(oldWidget);
  }

  void _animateChildSwap() {
    setState(() {
      // Update the children to animate.
      final Widget newChild = _grabTab(_thisTab);

      // TODO Expose this tab value
      // Animate out the current child
      _animatedChild = _currentChild
          .animate()
          .fadeOut(duration: 150.ms)
          .then(delay: 0.ms)
          .slideX(end: -0.1, curve: Curves.easeInOut);

      // Delay to allow the current animation to complete
      Future.delayed(20.ms, () {
        setState(() {
          // Update to the new child and animate it in
          _currentChild = newChild;
          _animatedChild = _currentChild
              .animate()
              .fadeIn(duration: 150.ms)
              .slideX(begin: 0.1, curve: Curves.easeInOut);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: _duration,
      child: AnimatedSwitcher(duration: Duration.zero, child: _animatedChild),
    );
  }
}
