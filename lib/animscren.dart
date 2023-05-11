import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key key}) : super(key: key);


  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen>
    with SingleTickerProviderStateMixin {
   AnimationController _controller;
   Animation<double> _widthAnimation;
   Animation<Color> _colorAnimation;
   Animation<double> _borderRadiusAnimation;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _widthAnimation = Tween<double>(begin: 50, end: 200)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _colorAnimation = ColorTween(begin: Colors.blue, end: Colors.green).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInCubic));

    _borderRadiusAnimation = Tween<double>(begin: 0.0, end: 50.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        _controller.reset();
        _controller.forward();
      }
    });
    _controller.forward();
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
        animation: _controller,
        builder: (context, child) {
          return Center(
            child: Container(
              width: _widthAnimation.value,
              height: _widthAnimation.value,
              decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius:
                BorderRadius.circular(_borderRadiusAnimation.value),
              ),
            ),
          );
        },
      ),
    );
  }
}