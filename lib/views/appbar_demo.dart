import 'package:flutter/material.dart';
import 'package:timer_work/core/appbar.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'First Screen',
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SecondScreen();
                },
              ));
            },
          ),
        ],
      ),
      body: Center(child: Text('This is the First Screen')),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Second Screen',
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            // Custom action for menu button
          },
        ),
        showImage: true,
        imageProvider: NetworkImage(
            'https://example.com/image.jpg'), // Provide an image URL
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Action for settings button
            },
          ),
        ],
      ),
      body: Center(child: Text('This is the Second Screen')),
    );
  }
}
