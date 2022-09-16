import 'package:flutter/material.dart';

class LoginRegisterButton extends StatefulWidget {
  final Function onChange;
  const LoginRegisterButton({
    Key? key,
    required this.onChange,
  }) : super(key: key);

  @override
  State<LoginRegisterButton> createState() => _LoginRegisterButtonState();
}

class _LoginRegisterButtonState extends State<LoginRegisterButton>
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
          curve: Curves.linear,
          reverseCurve: Curves.linear),
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
            width: 250.0,
            height: 50.0,
            decoration: const BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
            ),
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: _animation.value,
                  child: Container(
                    width: 125.0,
                    height: 50.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.black,
                      borderRadius: BorderRadius.all(
                        Radius.circular(40.0),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 125.0,
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    width: 125.0,
                    height: 50.0,
                    child: Center(
                      child: Text(
                        "REGISTER",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
