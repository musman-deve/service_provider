import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;

  final int maxLength;
  final TextAlignVertical textAlignVertical;
  final TextAlign textAlign;
  final Function onChanged;
  final double width;
  final Color textColor;
  final double elevation;
  final Widget leadingIcon;
  final Widget trailingIcon;
  final bool obscureText;
  final String validator;
  final bool isEmail;
  final bool isPhone;
  final double height;
  final Color textFieldColor;
  final TextEditingController controller;
  bool enable;
  final TextInputType keyBoardType;
  final TextStyle textStyle;
  final int maxLines;
  final int minLines;
  final EdgeInsets padding;

  AppTextField(
      {this.obscureText = false,
      this.hintText,
      this.textAlign,
      this.maxLength,
      this.textAlignVertical,
      this.onChanged,
      this.width,
      this.textColor,
      this.elevation,
      this.textFieldColor,
      this.leadingIcon,
      this.trailingIcon,
      this.maxLines,
      this.minLines,
      this.controller,
      this.isEmail = false,
      this.padding,
      this.height,
      this.isPhone = false,
      this.enable = true,
      this.keyBoardType = TextInputType.text,
      this.validator,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      // margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
      decoration: BoxDecoration(
        color: textFieldColor ?? Colors.grey.shade400,
        borderRadius: BorderRadius.circular(9),
      ),
      child: TextFormField(
          autocorrect: true,
          expands: obscureText ? false : true,
          maxLines: obscureText ? 1 : null,
          // minLines: minLines,
          enabled: enable,
          maxLength: maxLength,
          onChanged: onChanged(),
          controller: controller,
          keyboardType: keyBoardType,
          textAlignVertical: textAlignVertical ??
              (obscureText ? null : TextAlignVertical.center),
          textAlign: textAlign ?? TextAlign.start,
          obscureText: obscureText,
          decoration: InputDecoration(
            counterText: '',
            hintText: hintText,
            hintStyle: TextStyle(),
            border: InputBorder.none,
            prefixIcon: leadingIcon,
            suffixIcon: trailingIcon,
            enabled: enable,
            fillColor: Colors.white,
          ),
          // validator: (value) {
          //   if (value == null || value.isEmpty) {
          //     return 'Please Fill the field';
          //   } else if (isEmail && !GetUtils.isEmail(value)) {
          //     return 'Please enter correct email';
          //   } else if (obscureText && value.length < 6) {
          //     return 'Password should be 7 number longer';
          //   }
          //   return null;
          // },
          style: textStyle),
    );
  }
}
