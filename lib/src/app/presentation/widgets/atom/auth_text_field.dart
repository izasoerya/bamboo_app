import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final bool optional;
  final TextInputType type;
  final double width;
  final String? Function(String?)? validator;

  const AuthTextField({
    super.key,
    required this.controller,
    this.hintText = '',
    this.label = '',
    this.optional = false,
    this.type = TextInputType.text,
    this.width = 0.8,
    this.validator,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  final _formKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width.sw,
      child: TextFormField(
        key: _formKey,
        keyboardType: widget.type,
        controller: widget.controller,
        decoration: InputDecoration(
          focusColor: Colors.red,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 0.03.sw,
            vertical: 0.015.sh,
          ),
          hintText: widget.hintText,
          hintStyle:
              TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
          labelText: null,
          label: RichText(
            text: TextSpan(
              text: widget.label,
              style: Theme.of(context).textTheme.bodyMedium,
              children: [
                if (!widget.optional)
                  TextSpan(
                    text: ' (*)',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
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
        maxLines: null,
        minLines: 1,
      ),
    );
  }
}
