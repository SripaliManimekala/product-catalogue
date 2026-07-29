import 'package:flutter/material.dart';

/// Consistent fallback shown wherever a network image (`Image.network`)
/// fails to load, so broken images look the same across the app.
class NetworkImageError extends StatelessWidget {
  const NetworkImageError({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Center(
        child: Icon(
          Icons.image_not_supported_outlined,
          size: 48,
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
