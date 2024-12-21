import 'package:flutter/material.dart';
import '../../models/text_info.dart';

class ImageText extends StatelessWidget {
  final TextInfo textInfo;
  final String font;
  final bool isBold;
  final bool isItalic;

  const ImageText({
    required this.textInfo,
    required this.font,
    required this.isBold,
    required this.isItalic,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textInfo.text,
      style: TextStyle(
        fontFamily: font,
        fontSize: textInfo.fontSize,
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal, // Add italic logic
      ),
    );
  }
}
