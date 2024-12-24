import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final String label;
  final bool optional;
  final TextInputType type;

  const AuthTextField({
    super.key,
    required this.controller,
    this.validator,
    this.hintText = '',
    this.label = '',
    this.optional = false,
    this.type = TextInputType.text,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.8.sw,
      child: TextFormField(
        key: _formKey,
        keyboardType: widget.type,
        controller: widget.controller,
        decoration: InputDecoration(
          focusColor: Colors.red,
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          labelText: widget.label + (widget.optional ? ' (Optional)' : ''),
          labelStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          filled: true,
          fillColor: Theme.of(context).colorScheme.secondary,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        validator: widget.validator,
        onChanged: (value) {
          _formKey.currentState?.validate();
        },
      ),
    );
  }
}
