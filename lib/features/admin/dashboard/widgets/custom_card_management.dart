import 'package:flutter/material.dart';

class CustomCardManagement extends StatelessWidget {
  final void Function() onTap;
  final String title;
  final IconData icon;
  const CustomCardManagement({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Icon(icon, size: 40),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 25),
            ],
          ),
        ),
      ),
    );
  }
}
