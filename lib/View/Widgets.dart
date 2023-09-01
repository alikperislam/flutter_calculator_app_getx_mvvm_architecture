import 'package:flutter/material.dart';
import 'package:flutter_application_calculator/Model/ModelCalculate.dart';
import 'package:flutter_application_calculator/Model/ModelNavBar.dart';
import 'package:flutter_application_calculator/View/CalculatorPage.dart';
import 'package:flutter_application_calculator/ViewModel/Calculate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import '../ViewModel/CalculatorNavBar.dart';

mixin Widgets on State<CalculatorPage> {
  Rx<ModelNavBar> modelNavBar = ModelNavBar(isClickNavButton: true).obs;
  // dependency inversion ornegi:
  Rx<CalculatorNavBar> navBarValue =
      CalculatorNavBar(calculatorNavBar: ModelNavBar(isClickNavButton: true))
          .obs;
  //
  Rx<Calculate> calculate =
      Calculate(modelCalculate: ModelCalculate(calculateValue: "")).obs;

  Widget numbersContainer(
    Color? color,
    String? title,
    Color? textColor,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(150),
      onTap: () {
        updateClick() {
          calculate.update((value) {
            value!.modelCalculate?.calculateValue = title;
          });
        }

        // her tiklanan degeri ekrana yazdir.
        updateClick(); // dinleyiciyi tetikle guncelle.
        calculate.value.callValue(); // dinleyiciyi tetikle yazdir.
      },
      child: Ink(
        height: 85.r,
        width: 85.r,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(200.h),
        ),
        child: Center(
          child: Text(
            "$title",
            style: TextStyle(
              color: textColor,
              fontSize: ScreenUtil().setSp(30),
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget navBarButtons(
    double? buttonHeight,
    double? butttonwidth,
    Color? color,
    bool isClick,
    double? buttonRadius,
    String? text,
    Color? textColor,
    int? index,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(buttonRadius!),
      child: Ink(
        height: buttonHeight,
        width: butttonwidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(buttonRadius),
        ),
        child: Center(
          child: Text(
            "${text}",
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.normal,
              fontSize: ScreenUtil().setSp(18),
            ),
          ),
        ),
      ),
    );
  }
}
