import 'package:flutter/material.dart';
import 'package:jayjay_starter/widgets/demo/demo_button.dart';
import 'package:jayjay_starter/widgets/demo/demo_screen.dart';
import 'package:jayjay_starter/widgets/demo/demo_section.dart';

class StateManagementExample extends StatelessWidget {
  const StateManagementExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DemoScreen(
      title: 'State Management Example',
      sections: [
        DemoSection(
          title: 'Stateful Widget',
          children: [
            const CounterExample(),
          ],
        ),
        DemoSection(
          title: 'Inherited Widget',
          children: [
            const ThemeDataExample(),
          ],
        ),
        DemoSection(
          title: 'Provider',
          children: [
            DemoButton(
              text: 'Provider Example (Coming Soon)',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Provider example will be implemented soon'),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class CounterExample extends StatefulWidget {
  const CounterExample({super.key});

  @override
  State<CounterExample> createState() => _CounterExampleState();
}

class _CounterExampleState extends State<CounterExample> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Counter: $_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter--;
                    });
                  },
                  child: const Text('-'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _counter++;
                    });
                  },
                  child: const Text('+'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ThemeDataExample extends StatelessWidget {
  const ThemeDataExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Theme Data Example',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Primary Color: ${Theme.of(context).colorScheme.primary}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Text Style: ${Theme.of(context).textTheme.bodyMedium?.fontFamily}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
