import 'package:flutter/material.dart';

class Wtile extends StatelessWidget {
  final String? semanticLabel;
  final String text;
  final IconData? icon;
  final String? titleText;
  final String? descriptionText;
  final Color? color;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final Color? backgroundColor;
  final double? radius;

  const Wtile({
    super.key,
    this.semanticLabel,
    this.text = '',
    this.icon,
    this.titleText,
    this.descriptionText,
    this.color,
    this.style,
    this.padding,
    this.margin,
    this.width,
    this.backgroundColor,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel ?? text,
      child: Container(
        width: width,
        padding: padding ?? const EdgeInsets.all(15),
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor ?? color ?? Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              CircleAvatar(
                child: Icon(icon),
              ),
            if (icon != null) const SizedBox(height: 10),
            if (titleText != null)
              Text(
                titleText!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            if (descriptionText != null)
              Text(
                descriptionText!,
                style: style,
              ),
          ],
        ),
      ),
    );
  }
}
