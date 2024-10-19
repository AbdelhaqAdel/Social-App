
import 'package:flutter/material.dart';
import 'package:newapp/CleanArch/config/theme/colors.dart';

class AnimatedBackgroundScreen extends StatefulWidget {
  const AnimatedBackgroundScreen({super.key, required this.screen});
  final Widget screen;
  @override
  _AnimatedBackgroundScreenState createState() => _AnimatedBackgroundScreenState();
}

class _AnimatedBackgroundScreenState extends State<AnimatedBackgroundScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(_animation.value),
                  Colors.red.withOpacity(_animation.value),
                  AppColor.layoutBackgroundColor.withOpacity(_animation.value),
                  Colors.pink.withOpacity(_animation.value),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [1.0, 0.5, 0.5, 1.0],
              ),
            ),
            child:widget.screen
          );
        },
      ),
    );
  }
}