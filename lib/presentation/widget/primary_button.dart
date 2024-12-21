import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  final String text;
  final VoidCallback onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // Rounded corners
        ),
        padding:
            EdgeInsets.symmetric(vertical: 14, horizontal: 24), // Add padding
      ),
      child: Text(text,style: TextStyle(color: Colors.white),), // Text style
    );
  }
}
