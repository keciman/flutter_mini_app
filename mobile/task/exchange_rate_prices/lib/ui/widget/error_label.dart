import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorLabel extends StatelessWidget {
  final String errorText;
  const ErrorLabel({required this.errorText,super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: EdgeInsets.all(1.h), child: Text('Error: $errorText}')));
  }
}
