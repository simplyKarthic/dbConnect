import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Animater extends StatefulWidget {
  const Animater({Key key}) : super(key: key);

  @override
  State<Animater> createState() => _AnimaterState();
}

class _AnimaterState extends State<Animater> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation<double> _animation;
  CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_curvedAnimation);
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
      appBar: AppBar(title: Text("Animation"),),
      body: Container(
        padding: EdgeInsets.all(20),
        child: AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: _animation.value,
              child: Transform.scale(
                scale: _animation.value,
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
