import 'package:flutter/material.dart';

class MagicHairLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const MagicHairLogo({super.key, this.size = 100, this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = color ?? theme.colorScheme.primary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.circle_outlined,
              size: size,
              color: primaryColor.withOpacity(0.3),
            ),
            Icon(
              Icons.content_cut_rounded, // Tijeras
              size: size * 0.6,
              color: primaryColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          "Magic Hair",
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: primaryColor,
            fontStyle: FontStyle.italic,
            letterSpacing: 1.2,
          ),
        ),
        Text(
          "Estilismo Profesional",
          style: theme.textTheme.labelLarge?.copyWith(
            color: theme.colorScheme.secondary,
            letterSpacing: 3.0,
          ),
        ),
      ],
    );
  }
}
