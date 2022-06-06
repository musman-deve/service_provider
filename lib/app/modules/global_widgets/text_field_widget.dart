/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TextFieldWidget extends StatelessWidget {
  const TextFieldWidget({
    Key key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.obscureText,
    this.suffixIcon,
    this.leadingText,
    this.isFirst,
    this.isLast,
    this.style,
    this.bgColor,
    this.radius,
    this.height,
    this.textAlign,
    this.cursorHeight,
    this.suffix,
    this.margin,
    this.padding,
    this.showErrorBorder,
  }) : super(key: key);

  final FormFieldSetter<String> onSaved;
  final double height;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;
  final TextInputType keyboardType;
  final int maxLength;
  final String initialValue;
  final String hintText;
  final String errorText;
  final TextAlign textAlign;
  final String labelText;
  final TextStyle style;
  final Color bgColor;
  final bool showErrorBorder;
  final BorderRadius radius;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final IconData iconData;
  final String leadingText;
  final double cursorHeight;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget suffixIcon;
  final Widget suffix;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? null,
      padding: padding ?? EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      margin: margin ?? EdgeInsets.only(left: 20, right: 20, top: topMargin, bottom: bottomMargin),
      decoration: BoxDecoration(
          color: bgColor ?? Get.theme.primaryColor,
          borderRadius: radius ?? buildBorderRadius,
          boxShadow: [
            BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
          border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          (labelText != null)
              ? Text(
                  labelText ?? "",
                  style: Get.textTheme.bodyText1,
                  textAlign: textAlign ?? TextAlign.start,
                )
              : Container(),
          TextFormField(
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            maxLength: maxLength,
            key: key,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
            initialValue: initialValue ?? '',
            style: style ?? Get.textTheme.bodyText2,
            obscureText: obscureText ?? false,
            textAlign: textAlign ?? TextAlign.start,
            cursorHeight: cursorHeight,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: Get.textTheme.caption,
              counterText: '',
              errorBorder: (showErrorBorder ?? true)
                  ? OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.red))
                  : OutlineInputBorder(borderSide: BorderSide.none),
              prefixIcon: iconData != null
                  ? Icon(iconData, color: Get.theme.focusColor).marginOnly(right: 14)
                  : leadingText != null
                      ? Text(leadingText)
                      : SizedBox(),
              prefixIconConstraints: iconData != null
                  ? BoxConstraints.expand(width: 38, height: 38)
                  : BoxConstraints.expand(width: 0, height: 0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.symmetric(horizontal: 0),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon: suffixIcon,
              suffix: suffix,
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
