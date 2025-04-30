import 'package:flutter/material.dart';

class TextFieldWithSaveButton extends StatefulWidget {
  final Function(String)? onSave;
  final String? value;
  final String? labelText;
  final bool isLoading;

  const TextFieldWithSaveButton({
    super.key,
    this.onSave,
    this.value,
    this.labelText,
    this.isLoading = false,
  });

  @override
  State<TextFieldWithSaveButton> createState() =>
      _TextFieldWithSaveButtonState();
}

class _TextFieldWithSaveButtonState extends State<TextFieldWithSaveButton> {
  late TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.value);
    textController.addListener(() {
      setState(() {});
    });
  }

  @override
  void didUpdateWidget(TextFieldWithSaveButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value &&
        widget.value != textController.text) {
      textController.text = widget.value ?? '';
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isButtonVisible =
        (widget.onSave != null) &&
        (widget.value != textController.text) &&
        (!widget.isLoading);

    final suffixIcon =
        widget.isLoading
            ? const CircularProgressIndicator()
            : (isButtonVisible)
            ? IconButton(
              icon: const Icon(Icons.save),
              onPressed: () => widget.onSave!(textController.text),
            )
            : null;

    return TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        suffixIcon: suffixIcon,
      ),
      onSubmitted: widget.onSave,
    );
  }
}
