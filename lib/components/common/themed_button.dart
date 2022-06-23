import 'package:edu_app/theme/theme_utils.dart';
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

  final Widget label;
  final void Function()? onPressed;
  final ButtonVariant variant;
  final ButtonStyle style;
  final bool isActive;

  const factory ThemedButton.icon(
      {Key? key,
      required Widget icon,
      required Function() onPressed,
      ButtonVariant? variant,
      ButtonStyle style,
      Widget? label,
      bool isActive}) = _ThemedButtonWithIcon;

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
    ColorScheme variantColorScheme = selectVariant(context, variant);

    return ElevatedButton(
      style: style.merge(ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
        return fadeOnDisable(states, variantColorScheme.onPrimary);
      }), backgroundColor: MaterialStateProperty.resolveWith((states) {
        return fadeOnDisable(states, variantColorScheme.primary);
      }))),
      child: label,
      onPressed: isActive ? onPressed : null,
    );
  }
}

class _ThemedButtonWithIcon extends ThemedButton {
  const _ThemedButtonWithIcon(
      {Key? key,
      required this.icon,
      required Function() onPressed,
      Widget? label,
      ButtonVariant? variant,
      ButtonStyle? style,
      bool? isActive})
      : super(
            key: key,
            onPressed: onPressed,
            label: label ?? const Text(''),
            variant: variant ?? ButtonVariant.primary,
            style: style ?? const ButtonStyle(),
            isActive: isActive ?? true);

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    ColorScheme variantColorScheme = selectVariant(context, variant);

    return ElevatedButton.icon(
      style: style.merge(ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
        return fadeOnDisable(states, variantColorScheme.onPrimary);
      }), backgroundColor: MaterialStateProperty.resolveWith((states) {
        return fadeOnDisable(states, variantColorScheme.primary);
      }))),
      label: label,
      icon: icon,
      onPressed: isActive ? onPressed : null,
    );
  }
}

enum ButtonVariant { primary, secondary, tertiary }
