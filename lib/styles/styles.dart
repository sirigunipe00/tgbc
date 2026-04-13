
import 'package:flutter/material.dart';
import 'package:tgbc_app/core/core.dart';


final inputBorderStyle = BoxDecoration(
  // borderRadius: BorderRadius.circular(10),
  border: Border.all(color: Colors.grey),
);

const inputFieldDecoration = InputDecoration(
  border: InputBorder.none,
  contentPadding: EdgeInsets.all(16.0),
);

const captionStyle = TextStyle(
  fontWeight: FontWeight.bold,
  // color: Colors.grey,
  fontSize: 12,
);

const kLightGreyColor = Color(0xFFECEFF1);

const kDarkModeAppBarColor = Color(0xFF263238);

const kLightStatusBarColor = Color(0x99EDF1F2);

const kDarkStatusBarColor = Color(0xFF102027);

bool isDarkModeEnabled(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark;

const inputFieldCaptionStyle = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.bold,
    letterSpacing: 1.1);

TextStyle? countTextStyle(BuildContext context) => context.textTheme.bodyMedium?.copyWith(
  color: Colors.white,
  fontWeight: FontWeight.bold,

);