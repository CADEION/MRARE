import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:mrare/presentation/widget/image_text.dart';
import 'package:velocity_x/velocity_x.dart';

import '../widget/home_screen_edit_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeScreenEditViewModel {
  bool isBold = false; // Track if the text is bold
  bool isItalic = false; // Track if the text is italic
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "HI".text.make(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.3),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Stack(
                  children: [
                    for (int i = 0; i < texts.length; i++)
                      Positioned(
                        top: texts[i].top,
                        left: texts[i].left,
                        child: GestureDetector(
                          onLongPress: () => log('PRESSED onLongPress'),
                          onTap: () => setCurrentIndex(i, context),
                          child: Draggable(
                            feedback: ImageText(
                              textInfo: texts[i],
                              font: selectedFont, // Use selected font
                              isBold: isBold, // Pass the bold state
                              isItalic: isItalic, // Pass the italic state
                            ),
                            child: ImageText(
                              textInfo: texts[i],
                              font: selectedFont, // Use selected font
                              isBold: isBold, // Pass the bold state
                              isItalic: isItalic, // Pass the italic state
                            ),
                            onDragEnd: (details) {
                              final renderBox =
                                  context.findRenderObject() as RenderBox;
                              Offset off =
                                  renderBox.globalToLocal(details.offset);
                              setState(() {
                                texts[i].top = off.dy - 96;
                                texts[i].left = off.dx;
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
              DropdownButton<String>(
                value: selectedFont,
                items: fonts.map((font) {
                  return DropdownMenuItem<String>(
                    value: font,
                    child: Text(font),
                  );
                }).toList(),
                onChanged: (newFont) {
                  setState(() {
                    selectedFont = newFont!;
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: texts.isEmpty
                        ? null
                        : () {
                            setState(() {
                              texts[currentIndex].fontSize =
                                  (texts[currentIndex].fontSize - 2)
                                      .clamp(10.0, 50.0);
                            });
                          },
                    icon: const Icon(Icons.remove),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      texts.isEmpty
                          ? '-'
                          : '${texts[currentIndex].fontSize.toInt()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  IconButton(
                    onPressed: texts.isEmpty
                        ? null
                        : () {
                            setState(() {
                              texts[currentIndex].fontSize =
                                  (texts[currentIndex].fontSize + 2)
                                      .clamp(10.0, 50.0);
                            });
                          },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Bold Toggle
                  IconButton(
                    icon: Icon(
                      isBold ? Icons.format_bold : Icons.format_bold_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        isBold = !isBold; // Toggle the bold state
                      });
                    },
                  ),
                  // Italic Toggle
                  IconButton(
                    icon: Icon(
                      isItalic ? Icons.format_italic : Icons.format_italic_outlined,
                    ),
                    onPressed: () {
                      setState(() {
                        isItalic = !isItalic; // Toggle the italic state
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _addFabButton,
    );
  }

  Widget get _addFabButton => FloatingActionButton(
        onPressed: () => addNewDialogue(context),
        backgroundColor: Colors.grey.withOpacity(0.5),
        child: const Icon(Icons.edit),
        tooltip: 'Add New Text',
      );
}
