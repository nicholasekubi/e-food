import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;
  int maxLines;

  SmallText(
      {Key? key,
      this.color = const Color(0xFFccc7c5),
      required this.text,
      required this.maxLines,
      this.size = 12,
      this.height = 1.2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return maxLines != 0
        ? Text(
            text,
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: color,
                fontFamily: 'Roboto',
                fontSize: size,
                height: height),
          )
        : Text(
            text,
            // overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: color,
                fontFamily: 'Roboto',
                fontSize: size,
                height: height),
          );
  }
}
