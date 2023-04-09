import 'package:flutter/material.dart';

import 'color_const.dart';

class Styles {
  static const _poppinsBold = "Poppins-Bold";
  static const _poppinsSemiBold = "Poppins-SemiBold";
  static const _poppinsMedium = "Poppins-Medium";
  static const _poppinsRegular = "Poppins-Regular";
  static const _poppinsLight = "Poppins-Light";

  static bold({double size = 14, Color color = ColorConst.black}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _poppinsBold,
        color: color,
        fontWeight: FontWeight.bold);
  }

  static semiBold({double size = 14, Color color = ColorConst.black}) {
    return TextStyle(
      fontSize: size,
      fontFamily: _poppinsSemiBold,
      color: color,
    );
  }

  static regular({double size = 12, Color color = ColorConst.black}) {
    return TextStyle(
      fontSize: size,
      fontFamily: _poppinsRegular,
      color: color,
    );
  }

  static medium({double size = 14, Color color = ColorConst.black}) {
    return TextStyle(
      fontSize: size,
      fontFamily: _poppinsMedium,
      color: color,
    );
  }

  static mediumUnderline({double size = 14, Color color = ColorConst.black}) {
    return TextStyle(
        fontSize: size,
        fontFamily: _poppinsMedium,
        color: color,
        decoration: TextDecoration.underline);
  }

  static light({double size = 14, Color color = ColorConst.black}) {
    return TextStyle(
      fontSize: size,
      fontFamily: _poppinsLight,
      color: color,
    );
  }
}
