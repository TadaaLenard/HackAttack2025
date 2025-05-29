import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabeledTextField extends StatefulWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool isPrivate;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.isPrivate = false,
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPrivate ? _obscureText : false,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: widget.isPrivate
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  )
                : null,
          ),
        ),
      ],
    );
  }
}

class KeypadInputField extends StatefulWidget {
  final int length;
  final TextEditingController controller;

  const KeypadInputField({
    super.key,
    required this.length,
    required this.controller,
  });

  @override
  _KeypadInputFieldState createState() => _KeypadInputFieldState();
}

class _KeypadInputFieldState extends State<KeypadInputField> {
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(widget.length, (_) => FocusNode());
    _controllers = List.generate(widget.length, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var fn in _focusNodes) {
      fn.dispose();
    }
    for (var c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _updateMainController() {
    widget.controller.text = _controllers.map((c) => c.text).join();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (index) {
        return Container(
          width: 60,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: TextField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              if (value.isNotEmpty) {
                if (index < widget.length - 1) {
                  FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                } else {
                  _focusNodes[index].unfocus();
                }
              }
              _updateMainController();
            },
            onSubmitted: (_) => _updateMainController(),
          ),
        );
      }),
    );
  }
}

class DateField extends StatelessWidget {
  final String label;
  final String placeholder;
  final TextEditingController controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const DateField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: placeholder,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}
