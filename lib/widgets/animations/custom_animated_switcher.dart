import 'package:champion_tabs/models/fade_type.dart';
import 'package:flutter/widgets.dart';

class CustomAnimatedSwitcher extends StatelessWidget {
  const CustomAnimatedSwitcher({
    super.key,
    required this.child,
    this.fadeType = FadeType.scale,
    this.duration = const Duration(milliseconds: 300),
  });

  final Widget child;
  final FadeType fadeType;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: duration,
      curve: Curves.easeInOut,
      child: AnimatedSwitcher(
        duration: duration,
        switchInCurve: Curves.decelerate,
        transitionBuilder: (child, animation) {
          if (fadeType == FadeType.scale) {
            return ScaleTransition(scale: animation, child: child);
          } else if (fadeType == FadeType.slide) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0),
                end: const Offset(0, 0),
              ).animate(animation),
              child: child,
            );
          } else {
            return FadeTransition(opacity: animation, child: child);
          }
        },
        child: child,
      ),
    );
  }
}
