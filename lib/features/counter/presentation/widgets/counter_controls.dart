import 'package:flutter/material.dart';

/// Widget containing counter control buttons
/// Demonstrates widget composition and callbacks
class CounterControls extends StatelessWidget {
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onReset;

  const CounterControls({
    super.key,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Decrement button
            FloatingActionButton(
              onPressed: onDecrement,
              heroTag: 'decrement_button',
              tooltip: 'Decrement',
              child: const Icon(Icons.remove),
            ),
            const SizedBox(width: 24),
            // Increment button
            FloatingActionButton(
              onPressed: onIncrement,
              heroTag: 'increment_button',
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Reset button
        ElevatedButton.icon(
          onPressed: onReset,
          icon: const Icon(Icons.refresh),
          label: const Text('Reset Counter'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }
}
