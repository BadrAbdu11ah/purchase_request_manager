import 'package:flutter/material.dart';

class CustomCardCount extends StatelessWidget {
  final int length;
  final String title;
  const CustomCardCount({super.key, required this.length, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  child: Text(
                    "$length",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
