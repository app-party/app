import 'package:flutter/material.dart';

enum GradientPatterns { orange, pink, blue }

class GradientButton extends StatelessWidget {
  final double height;
  final String text;
  final GradientPatterns pattern;
  final VoidCallback fn;
  final bool useFractionalSizedBox;
  final EdgeInsetsGeometry? padding;

  final Map<GradientPatterns, List<Color>> colorPatterns = {
    GradientPatterns.orange: [Color(0xFFEE4F43), Color(0xFFFAB638)],
    GradientPatterns.pink: [Color(0xFFEE5075), Color(0xFFD0629F)],
    GradientPatterns.blue: [Color(0xFF3E6391), Color(0xFF3F679D)],
  };

  GradientButton({
    Key? key,
    required this.text,
    required this.fn,
    this.height = 75,
    this.useFractionalSizedBox = true,
    this.pattern = GradientPatterns.orange,
    this.padding,
  })  : assert(GradientPatterns.values.contains(pattern),
            "Pattern must be ${GradientPatterns.values}"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      child: ElevatedButton(
        onPressed: fn,
        child: buildFractionalSizedBox(
          child: Ink(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: colorPatterns[pattern]!)),
            child: Center(child: Text(text)),
          ),
        ),
      ),
    );
  }

  Widget buildFractionalSizedBox({required Widget child}) {
    if (useFractionalSizedBox)
      return FractionallySizedBox(
        widthFactor: 1,
        child: child,
      );
    return child;
  }
}
