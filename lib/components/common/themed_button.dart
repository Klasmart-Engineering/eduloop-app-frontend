import 'package:flutter/material.dart';

class ThemedButton extends StatelessWidget {
  const ThemedButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.variant = ButtonVariant.primary,
      this.style = const ButtonStyle(),
      this.isActive = true})
      : super(key: key);

  final String label;
  final void Function() onPressed;
  final ButtonVariant variant;
  final ButtonStyle style;
  final bool isActive;

  ColorScheme selectVariant(BuildContext context, ButtonVariant variant) {
    ColorScheme globalScheme = Theme.of(context).colorScheme;
    switch (variant) {
      case ButtonVariant.secondary:
        {
          return globalScheme.copyWith(
              primary: globalScheme.secondary,
              onPrimary: globalScheme.onSecondary);
        }
      case ButtonVariant.tertiary:
        {
          return globalScheme.copyWith(
              primary: globalScheme.tertiary,
              onPrimary: globalScheme.onTertiary);
        }
      default:
        {
          return globalScheme;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme variantScheme = selectVariant(context, variant);

    return Theme(
      data: ThemeData(
        elevatedButtonTheme: Theme.of(context).elevatedButtonTheme,
      ),
      child: ElevatedButton(
        style: style,
        child: Text(label),
        onPressed: isActive ? onPressed : null,
      ),
    );
  }
}

enum ButtonVariant { primary, secondary, tertiary }
