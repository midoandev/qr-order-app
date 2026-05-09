import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IPOT QR Order'),
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.qr_code_scanner,
              size: 100,
              color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 20),
            Text(
              'Welcome to Restaurant App',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to scan QR
              },
              child: const Text('Scan Table QR'),
            ),
          ],
        ),
      ),
    );
  }
}