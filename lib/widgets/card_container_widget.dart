import 'package:flutter/material.dart';

class CardContainerWidget extends StatelessWidget {
  const CardContainerWidget({super.key, required this.bgColor, this.child});
  final Color bgColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
    );
  }
}
