import 'package:flutter/material.dart';
import 'package:mrare/models/text_info.dart';
import 'package:mrare/presentation/widget/primary_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:mrare/presentation/screens/home_screen.dart';

abstract class HomeScreenEditViewModel extends State<HomeScreen> {
  TextEditingController controller = TextEditingController();

  List<TextInfo> texts = [];
  final List<String> fonts = ['Roboto', 'Pacifico'];
  String selectedFont = 'Roboto'; // Track the selected font

  int currentIndex = 0;

  setCurrentIndex(int index, BuildContext context) {
    if (index >= 0 && index < texts.length) {
      setState(() {
        currentIndex = index;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected For Editing')),
      );
    }
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  addNewText() {
    setState(() {
      texts.add(TextInfo(
        text: controller.text.trim(),
        left: 0,
        top: 0,
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 16,
        fontFamily: selectedFont, // Apply the selected font here
        textAlign: TextAlign.left,
      ));
    });
    Navigator.pop(context);
  }

  addNewDialogue(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: VxTextField(
            controller: controller,
            fillColor: Colors.white.withOpacity(0.4),
            borderColor: Colors.black.withOpacity(0.7),
            maxLine: 3,
            hint: 'ADD TEXT',
            hintStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 22,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          actions: [
            PrimaryButton(
              text: 'Add',
              onPressed: addNewText,
              color: Colors.blue,
            ),
            PrimaryButton(
              text: 'Close',
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: const Color.fromARGB(255, 243, 68, 33),
            ),
          ],
        );
      },
    );
  }

  // Dropdown for font selection
  Widget fontSelector() {
    return DropdownButton<String>(
      value: selectedFont,
      onChanged: (newValue) {
        setState(() {
          selectedFont = newValue!;
        });
      },
      items: fonts.map((font) {
        return DropdownMenuItem<String>(
          value: font,
          child: Text(font),
        );
      }).toList(),
    );
  }
}
