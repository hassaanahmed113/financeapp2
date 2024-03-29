import 'package:finance_track_app/core/utils.dart';
import 'package:finance_track_app/core/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget customElevetedBtn(onpressed, text, double? fontsize) {
  return SizedBox(
    width: Get.width,
    height: 50,
    child: ElevatedButton(
        style:
            TextButton.styleFrom(backgroundColor: ColorConstraint.primeColor),
        onPressed: onpressed,
        child: customTextWidget(
            text, ColorConstraint().primaryColor, FontWeight.w500, fontsize)),
  );
}

Widget customElevetedBtnWid(onpressed, text, double? fontsize, double wid) {
  return SizedBox(
    width: wid,
    height: 40,
    child: ElevatedButton(
        style:
            TextButton.styleFrom(backgroundColor: ColorConstraint.primeColor),
        onPressed: onpressed,
        child: customTextWidget(
            text, ColorConstraint().primaryColor, FontWeight.w500, fontsize)),
  );
}
