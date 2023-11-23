import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final IconData iconData;
  final void Function() onTap;
  const CustomIconButton({required this.iconData,required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: onTap,
      icon: Icon(
        iconData,
        size: 24.0,
        color: Colors.white,
      ),
    );
  }
}
