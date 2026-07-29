import 'package:flutter/material.dart';

/// A consistent loading indicator used across the app so the user is never
/// left staring at a blank screen while data is being fetched.
class LoadingView extends StatelessWidget {
  final String message;

  const LoadingView({super.key, this.message = 'Loading products...'});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}