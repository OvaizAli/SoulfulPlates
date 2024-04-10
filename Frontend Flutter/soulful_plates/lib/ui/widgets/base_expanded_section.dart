import 'package:flutter/material.dart';

///[BaseExpandedSection] gives expanded animation to its child
///[child] uses the widget on which you want to give the animation
///[expand] uses the bool value [expanded animation will be applied if set to true]
///[duration] uses the duration of the animation
///
/// Example
/// BaseExpandedSection(
///   expand: true,
///   child: child,
///   duration: const Duration(milliseconds: 1500),
/// )

class BaseExpandedSection extends StatefulWidget {
  const BaseExpandedSection({
    Key? key,
    required this.expand,
    required this.child,
    this.duration,
  }) : super(key: key);

  final Widget child;
  final bool expand;
  final Duration? duration;

  @override
  BaseExpandedSectionState createState() => BaseExpandedSectionState();
}

class BaseExpandedSectionState extends State<BaseExpandedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController expandController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
      vsync: this,
      duration: widget.duration ??
          const Duration(
            milliseconds: 500,
          ),
    );
    animation = CurvedAnimation(
      parent: expandController,
      curve: Curves.fastOutSlowIn,
    );
  }

  /// checking the value of expand
  void _runExpandCheck() {
    if (widget.expand) {
      expandController.forward();
    } else {
      expandController.reverse();
    }
  }

  @override
  void didUpdateWidget(BaseExpandedSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    expandController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axisAlignment: 1.0,
      sizeFactor: animation,
      child: widget.child,
    );
  }
}