import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoleAccount extends StatefulWidget {
  final void Function(bool) onChanged;
  const RoleAccount({super.key, required this.onChanged});

  @override
  State<RoleAccount> createState() => _RoleAccountState();
}

class _RoleAccountState extends State<RoleAccount> {
  bool _selectedRole = true;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () => setState(() {
            widget.onChanged(true);
            _selectedRole = true;
          }),
          child: Container(
            width: 0.3.sw,
            padding: EdgeInsets.symmetric(vertical: 0.025.sw),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _selectedRole
                  ? Colors.blue
                  : Theme.of(context).colorScheme.secondary,
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'User',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => setState(() {
            widget.onChanged(false);
            _selectedRole = false;
          }),
          child: Container(
            width: 0.3.sw,
            padding: EdgeInsets.symmetric(vertical: 0.025.sw),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: _selectedRole
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.blue,
              boxShadow: [
                BoxShadow(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Text(
              'Organization',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
