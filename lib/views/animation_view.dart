import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:spatium_task/custom_circle_shap/circular_slider.dart';
import 'package:spatium_task/views/posts_view.dart';
import 'package:spatium_task/widget/progress_background_shape_widget.dart';

import '../widget/progress_forground_shape_widget.dart';

class AnimationCircleView extends StatelessWidget {
  const AnimationCircleView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: CircleShapeWidget()),
    );
  }
}

class CircleShapeWidget extends StatefulWidget {
  const CircleShapeWidget({
    super.key,
  });

  @override
  State<CircleShapeWidget> createState() => _CircleShapeWidgetState();
}

class _CircleShapeWidgetState extends State<CircleShapeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _sliderValue = 2.5;

  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
  }

  _handleNavigation() {
    if (_sliderValue == 10) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PostsView()),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      height: 500,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        border: Border.all(color: Colors.black12, width: 1),
      ),
      child: Center(
        child: Stack(
          children: [
            _backgroundShapeWidget(),
            _foregroundShapeWidget(),
            _textCircleWidget(),
            _circleSliderWidget(),
          ],
        ),
      ),
    );
  }

  Positioned _circleSliderWidget() {
    return Positioned(
      top: 40,
      left: 50,
      child: SleekCircularSlider(
        min: 0,
        max: 10,
        initialValue: 2.5,
        onChange: (double value) {
          setState(() {
            _sliderValue = value;
            _handleNavigation();
          });
        },
      ),
    );
  }

  Positioned _textCircleWidget() {
    return Positioned(
      top: 70,
      left: 100,
      right: 100,
      child: CircleAvatar(
        backgroundColor: Colors.greenAccent.shade100,
        radius: 70,
        child: Text(
          "${(_sliderValue * 10).round()}%",
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Animate _foregroundShapeWidget() {
    return Animate(
      controller: _animationController,
      child: CustomPaint(
        size: const Size(300, 300),
        painter: ProgressForegroundCircleShape(
            isBackground: false,
            arc: _sliderValue / 3.18,
            progressColor: Colors.greenAccent),
      ),
    );
  }

  CustomPaint _backgroundShapeWidget() {
    return CustomPaint(
      size: const Size(300, 300),
      painter: ProgressBackgroundCircleShape(
          isBackground: true, arc: null, progressColor: Colors.grey),
    );
  }
}
