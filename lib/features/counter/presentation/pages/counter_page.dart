import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/counter_controls.dart';
import '../widgets/counter_display.dart';

/// Counter Page - Main UI for the Counter feature
/// Demonstrates BLoC pattern and state management
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _increment() {
    setState(() {
      _counter++;
    });
  }

  void _decrement() {
    setState(() {
      _counter--;
    });
  }

  void _reset() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clean Architecture Counter'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CounterDisplay(value: _counter),
              const SizedBox(height: 48),
              CounterControls(
                onIncrement: _increment,
                onDecrement: _decrement,
                onReset: _reset,
              ),
              const SizedBox(height: 48),
              // Navigation button to demonstrate routing
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to user list page using go_router
                  context.go('/users');
                },
                icon: const Icon(Icons.people),
                label: const Text('View User List (API Demo)'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Navigation button for Rick and Morty characters
              OutlinedButton.icon(
                onPressed: () {
                  // Navigate to characters page using go_router
                  context.go('/characters');
                },
                icon: const Icon(Icons.movie),
                label: const Text('View Rick & Morty Characters'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}