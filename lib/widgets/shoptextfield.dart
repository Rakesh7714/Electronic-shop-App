import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShopTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  bool isPassword;
  bool? check;
  Widget? icon;
  int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  final TextInputType? inputType;

  ShopTextField(
      {this.hintText,
      this.controller,
      this.check,
      this.validate,
      this.maxLines,
      this.isPassword = false,
      this.icon,
      this.focusNode,
      this.inputAction,
      this.inputType});

  @override
  State<ShopTextField> createState() => _ShopTextFieldState();
}

class _ShopTextFieldState extends State<ShopTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
           margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
           decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
           child: TextFormField(
        
       // maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        keyboardType: widget.inputType,
        focusNode: widget.focusNode,
        textInputAction: widget.inputAction,
        obscureText: widget.isPassword == false ? false : widget.isPassword,
        controller: widget.controller,
        validator: widget.validate,
        decoration: InputDecoration(
            border: InputBorder.none,
            suffixIcon: widget.icon,
            hintText: widget.hintText ?? 'hint Text',
            contentPadding: EdgeInsets.all(10)),
      ),
    );
  }
}
