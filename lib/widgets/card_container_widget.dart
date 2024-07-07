import 'package:flutter/material.dart';

class CardContainerWidget extends StatelessWidget {
  const CardContainerWidget({super.key, required this.bgColor, this.child});
  final Color bgColor;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 45),
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(90)),
      child: child,
    );
  }
}
