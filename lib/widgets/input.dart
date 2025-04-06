

import 'package:flutter/material.dart';


class InputForm extends StatelessWidget {

  final TextEditingController  ?controller;
  final String ? hint;
  final Widget ? prefix;
  final int maxLine;
  final String? Function(String?)? validator;
  final InputDecoration ? decoration;
  final TextInputType ? keyboardType;
  final EdgeInsets ? padding;
  const InputForm({super.key,this.padding,this.decoration,this.maxLine=1,this.controller,this.validator,this.hint,this.prefix, this.keyboardType});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: padding ??  const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLine,
        keyboardType: keyboardType,
        decoration: decoration ?? InputDecoration(
          hintText: hint,
          isDense: true,
          contentPadding: const EdgeInsets.all(12.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.all(
              Radius.circular(99),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(99),
            ),
          ),
          prefixIcon: prefix,
        ),
      ),
    );
  }
}

