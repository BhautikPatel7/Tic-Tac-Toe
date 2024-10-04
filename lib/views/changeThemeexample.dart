import 'package:flutter/material.dart';
import 'package:timer_work/components/custom_card.dart';
import 'package:timer_work/core/app_theme.dart';

class MyAppThemeExample extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyAppThemeExample> {
  // State to manage theme mode (light/dark)
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: HomeScreen(
        isDarkMode: _isDarkMode,
        onThemeToggle: _toggleTheme,
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback onThemeToggle;

  HomeScreen({required this.isDarkMode, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Theme Management"),
        actions: [
          Switch(
            value: isDarkMode,
            onChanged: (value) {
              onThemeToggle();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomCard(
              title: "Card 1",
              content:
                  "This is the content of the first card. Switch the theme to see changes.",
            ),
            const SizedBox(height: 20),
            CustomCard(
              title: "Card 2",
              content:
                  "This card also adapts to the theme. Try toggling dark mode!",
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example button for theme changes
              },
              child: Text("A Button Example"),
            ),
          ],
        ),
      ),
    );
  }
}
