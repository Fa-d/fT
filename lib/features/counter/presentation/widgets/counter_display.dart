import 'package:flutter/material.dart';

/// Widget to display the counter value
/// This is a reusable presentation widget
class CounterDisplay extends StatelessWidget {
  final int value;

  const CounterDisplay({
    super.key,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Current Counter Value:',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 16),
        // Animated counter with hero animation
        Hero(
          tag: 'counter_value',
          child: Material(
            color: Colors.transparent,
            child: Text(
              '$value',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
