import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/counter_bloc.dart';
import '../widgets/counter_controls.dart';
import '../widgets/counter_display.dart';

/// Counter Page - Main UI for the Counter feature
/// Demonstrates BLoC pattern and state management
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Inject the CounterBloc using dependency injection
      create: (_) => sl<CounterBloc>()..add(LoadCounterEvent()),
      child: Scaffold(
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
                // BlocBuilder rebuilds UI based on state changes
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    if (state is CounterLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is CounterLoaded) {
                      return Column(
                        children: [
                          CounterDisplay(value: state.counter.value),
                          const SizedBox(height: 48),
                          CounterControls(
                            onIncrement: () {
                              context
                                  .read<CounterBloc>()
                                  .add(IncrementCounterEvent());
                            },
                            onDecrement: () {
                              context
                                  .read<CounterBloc>()
                                  .add(DecrementCounterEvent());
                            },
                            onReset: () {
                              context
                                  .read<CounterBloc>()
                                  .add(ResetCounterEvent());
                            },
                          ),
                        ],
                      );
                    } else if (state is CounterError) {
                      return Column(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 60,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Error: ${state.message}',
                            style: const TextStyle(color: Colors.red),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.read<CounterBloc>().add(LoadCounterEvent());
                            },
                            child: const Text('Retry'),
                          ),
                        ],
                      );
                    }
                    // Initial state
                    return const CircularProgressIndicator();
                  },
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
