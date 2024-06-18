import 'package:flutter/material.dart';

class StreakPage extends StatefulWidget {
  const StreakPage({super.key});

  @override
  State<StreakPage> createState() => _StreakPageState();
}

class _StreakPageState extends State<StreakPage> {
  int _dayCount = 0;

  final String _initialImage = 'assets/images/defaultstreak.png';
  final String _updatedImage = 'assets/images/updatedstreak.png';

  void _incrementDay() {
    setState(() {
      _dayCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Track Your Progress',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _dayCount < 5
                  ? "Slow And Steady Wins The Race"
                  : "Nice work, keep it up!",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              _dayCount >= 5 ? _updatedImage : _initialImage,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'Day: $_dayCount',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 40,
              onPressed: _incrementDay,
            ),
          ],
        ),
      ),
    );
  }
}
