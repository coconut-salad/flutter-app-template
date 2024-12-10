import "package:flutter/material.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Placeholder Screen"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.hourglass_empty,
              size: 100,
              color: Colors.grey,
            ),
            const SizedBox(height: 20),
            const Text(
              "Your content here",
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
