import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.discreteCircle(
          color: Colors.green.shade300,
          secondRingColor: Colors.green.shade500,
          thirdRingColor: Colors.green.shade900,
          size: 165,
        ),
      ),
    );
  }
}
