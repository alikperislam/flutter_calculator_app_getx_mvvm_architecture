import 'package:flutter/material.dart';
import 'package:flutter_application_calculator/Model/ModelNavBar.dart';
import 'package:flutter_application_calculator/ViewModel/CalculatorNavBar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import '../ViewModel/ColorPalette.dart';
import '../ViewModel/NumberList.dart';
import 'Widgets.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> with Widgets {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.bgColor,
      body: Stack(
        children: [
          // ust kisimda bulunan navigation bar Row(buton-buton)
          navBar(),
          // Column[hesaplarin yazdirildigi text kismi
          // sonucun gosterildigi text kismi]
          textColumns(),
          // tuslarin bulundugu konteyner.
          konteyner(),
        ],
      ),
    );
  }

  Widget textColumns() {
    return Padding(
      padding: EdgeInsets.only(right: 39.w, left: 39.w),
      child: Column(
        children: [
          // hesaplama islemi
          calculateText(),
          // sonuc gosterme islemi
          resultText(),
        ],
      ),
    );
  }

  Widget calculateText() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 271.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  "${calculate.value.totalValue}",
                  style: TextStyle(
                    color: ColorPalette.calculateColor,
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultText() {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: EdgeInsets.only(top: 5.h),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          reverse: true,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Obx(
                () => Text(
                  "${calculate.value.result}",
                  style: TextStyle(
                    color: ColorPalette.textColor,
                    fontSize: ScreenUtil().setSp(25),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget navBar() {
    return Padding(
      padding: EdgeInsets.only(top: 60.h, left: 39.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // calculator button
          navBarButtons(
              47.h,
              153.w,
              (modelNavBar.value.isClickNavButton!)
                  ? ColorPalette.orangeButtonColor
                  : ColorPalette.bgColor,
              false,
              40.w,
              "Calculator",
              ColorPalette.textColor,
              0),
        ],
      ),
    );
  }

  Widget konteyner() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Ink(
        height: 550.h,
        width: Get.width,
        decoration: BoxDecoration(
            color: ColorPalette.containerColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.w),
              topRight: Radius.circular(40.w),
            )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //
            numberRows(0),
            //
            numberRows(4),
            //
            numberRows(8),
            //
            numberRows(12),
            //
            numberRows(16),
          ],
        ),
      ),
    );
  }

  Widget numberRows(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
          child: numbersContainer(
            NumberList.numara[index]![0]!,
            NumberList.numara[index]![1]!,
            NumberList.numara[index]![2]!,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
          child: numbersContainer(
            NumberList.numara[index + 1]![0]!,
            NumberList.numara[index + 1]![1]!,
            NumberList.numara[index + 1]![2]!,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, right: 10.w),
          child: numbersContainer(
            NumberList.numara[index + 2]![0]!,
            NumberList.numara[index + 2]![1]!,
            NumberList.numara[index + 2]![2]!,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: numbersContainer(
            NumberList.numara[index + 3]![0]!,
            NumberList.numara[index + 3]![1]!,
            NumberList.numara[index + 3]![2]!,
          ),
        ),
      ],
    );
  }
}
