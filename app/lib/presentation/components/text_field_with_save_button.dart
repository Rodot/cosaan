import 'package:flutter/material.dart';

Widget textFieldWithSaveButton({
  Function(String)? onSave,
  String? value,
  String? labelText,
}) {
  final textController = TextEditingController(text: value);

  return StatefulBuilder(
    builder: (context, setState) {
      textController.addListener(() {
        setState(() {});
      });
      final isButtonVisible =
          (onSave != null) && (value != textController.text);
      return TextField(
        controller: textController,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(),
          suffixIcon:
              (isButtonVisible)
                  ? IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () => onSave(textController.text),
                  )
                  : null,
        ),
        onSubmitted: onSave,
      );
    },
  );
}
