import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomAppBar extends StatelessWidget {
  final String title;
  final Widget leading;
  final double opacityValue;
  CustomAppBar(
      {@required this.leading, this.title = '', this.opacityValue = 1});
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 56.0,
        margin: const EdgeInsets.symmetric(horizontal: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Opacity(
              opacity: opacityValue,
              child: leading,
            ),
            Opacity(
              opacity: opacityValue,
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}



class CustomBackIconAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Transform.rotate(
          angle: math.pi / 4,
          child: Container(
            height: 2.0,
            width: 18.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black,
            ),
          ),
        ),
        Transform.rotate(
          angle: -math.pi / 4,
          child: Container(
            height: 2.0,
            width: 18.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}

