import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class CustomAnimation {
  static Animation animations(AnimationController controller) {
    final Animation _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeIn,
      ),
    );
    return _opacityAnimation;
  }
}
