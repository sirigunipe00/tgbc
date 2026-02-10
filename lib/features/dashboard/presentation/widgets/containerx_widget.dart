import 'package:flutter/material.dart';

class ContainerX extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final ImageProvider<Object>? backgroundImage;
  final double borderRadius;
  final bool addShadow;

  const ContainerX({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
    this.padding = const EdgeInsets.all(12),
    this.backgroundImage,
    this.borderRadius = 21,
    this.addShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: backgroundImage != null
              ? DecorationImage(image: backgroundImage!, fit: BoxFit.fill)
              : null,
          color: backgroundImage != null ? null : const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          border: Border.all(color: const Color(0xFF263238), width: 1),
          boxShadow: addShadow
              ? [
                  const BoxShadow(
                    color: Color(0xFF808080),
                    offset: Offset(4, 4),
                    blurRadius: 0,
                    spreadRadius: 0,
                  )
                ]
              : null),
      width: MediaQuery.sizeOf(context).width,
      margin: margin,
      padding: padding,
      child: child,
    );
  }
}
