import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  final Function onChange;
  const CustomToggleSwitch({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch>
    with SingleTickerProviderStateMixin {
  bool isChecked = false;
  final Duration _duration = const Duration(milliseconds: 150);
  late Animation<Alignment> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: _duration);

    _animation =
        AlignmentTween(begin: Alignment.centerLeft, end: Alignment.centerRight)
            .animate(
      CurvedAnimation(
          parent: _animationController,
          curve: Curves.bounceOut,
          reverseCurve: Curves.bounceIn),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            setState(() {
              if (_animationController.isCompleted) {
                _animationController.reverse();
              } else {
                _animationController.forward();
              }

              isChecked = !isChecked;
              widget.onChange();
            });
          },
          child: Container(
            width: 50.0,
            height: 50.0,
            padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
            decoration: BoxDecoration(
              color: isChecked ? Colors.teal.shade200 : Colors.grey.shade300,
              borderRadius: const BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: _animation.value,
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
