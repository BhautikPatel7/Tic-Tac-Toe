import 'package:flutter/material.dart';
import 'package:timer_work/widget/custom_button.dart';

class CustomButtonComponents extends StatelessWidget {
  const CustomButtonComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          text: "Submit",
          onPressed: () {
            print("Button pressed");
          },
          color: Colors.green,
        ),
      ),
    );
  }
}
