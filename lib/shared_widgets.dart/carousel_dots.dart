import 'package:flutter/material.dart';

class CarouselDots extends StatelessWidget {
  final int dotsNumber;
  final int activeIndex;

  CarouselDots({this.dotsNumber, this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        dotsNumber,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          height: 5.0,
          width: 5.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeIndex == index ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
