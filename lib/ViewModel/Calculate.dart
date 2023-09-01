import 'package:flutter_application_calculator/Model/ModelCalculate.dart';
import 'package:function_tree/function_tree.dart';
import 'package:intl/intl.dart';

abstract class ICalculate with IResultValue {
  void deleteValue();
  void resetValue();
  void resultValue();
  void callValue();
}

abstract class IResultValue {
  String? result;
  String? totalValue;
  int? dotClick;
  int? dotCount;
  bool? click;
  bool? last;
}

NumberFormat formatter = NumberFormat.decimalPatternDigits(
  locale: 'tr_tr',
  decimalDigits: 2,
);

class Calculate implements ICalculate {
  @override
  String? result = "";
  @override
  String? totalValue = "";
  @override
  int? dotClick = 0;
  @override
  int? dotCount = 0;
  @override
  bool? click = false;
  @override
  bool? last = true;

  // dependency inversion
  ModelCalculate? modelCalculate;
  Calculate({required this.modelCalculate});

  // modelden degiskeni aldik ilgili businnes kodlarini yazabiliriz.
  @override
  void deleteValue() {
    if (null != totalValue) {
      int len = totalValue.toString().length;
      if (len > 0) {
        // son elemani sil.
        if (totalValue![len - 1] == ".") {
          dotCount = dotCount! - 1;
          if (dotCount == 1 && dotClick == 1) {
            click = true;
          } else {
            click = false;
          }
          totalValue = totalValue!.substring(0, totalValue!.length - 1);
        } else {
          totalValue = totalValue!.substring(0, totalValue!.length - 1);
        }
      }
    }
  }

  @override
  void resetValue() {
    // text sifirla
    modelCalculate!.calculateValue = "";
    totalValue = "";
    result = "";
    //
    dotClick = 0;
    dotCount = 0;
  }

  @override
  void resultValue() {
    // hesaplanan ve donen sonuc gosterimi
    result = (formatter
                .format(totalValue.toString().interpret())
                .toString()
                .length <=
            16)
        ? formatter.format(totalValue.toString().interpret()).toString()
        : totalValue.toString().interpret().toStringAsPrecision(7);
  }

  @override
  void callValue() {
    if (modelCalculate?.calculateValue == "C") {
      // temizleme
      resetValue();
    }
    if (modelCalculate?.calculateValue == "=") {
      // sonuc dondurme ve hesaplama.
      if (lastElement() ?? false) {
        resultValue();
      }
    }
    if (modelCalculate?.calculateValue == "<") {
      // sildirme fonksiyonunu cagir son elemani sildir.
      deleteValue();
    }
    // yazdirma kisimlari:
    if (modelCalculate?.calculateValue != "C" &&
        modelCalculate?.calculateValue != "=" &&
        modelCalculate?.calculateValue != "<") {
      int len = totalValue.toString().length;
      if (len == 0) {
        // ilk eleman girisi cozumu.
        if (modelCalculate?.calculateValue == "^" ||
            modelCalculate?.calculateValue == "/" ||
            modelCalculate?.calculateValue == "*" ||
            modelCalculate?.calculateValue == "+" ||
            modelCalculate?.calculateValue == ".") {
          // herhangi bir eleman girmeyecek.
          last = false;
        } else if (modelCalculate?.calculateValue == "-") {
          last = false;
          // ilk eleman - olabilir.
          totalValue = totalValue! + (modelCalculate?.calculateValue ?? null)!;
        }
        // ilk eleman sayi oldugu icin giris yapiliyor.
        else {
          totalValue = totalValue! + (modelCalculate?.calculateValue ?? null)!;
        }
      }
      // ilk elemandan sonraki girisler:
      else {
        // bir onceki eleman eger bir operator veya . ise
        if (lastElement() == false && last == false) {
          if ((modelCalculate?.calculateValue == "^" ||
              modelCalculate?.calculateValue == "/" ||
              modelCalculate?.calculateValue == "*" ||
              modelCalculate?.calculateValue == "+" ||
              modelCalculate?.calculateValue == ".")) {
            // hicir sey yapmayacak bu sayede ust uste operator yazilmiyor.
          } else if (modelCalculate?.calculateValue == "-") {
            //
            if (totalValue.toString().substring(len - 1) == "*" ||
                totalValue.toString().substring(len - 1) == "/" ||
                totalValue.toString().substring(len - 1) == "^") {
              // bir onceki deger ^ * veya / operatorleri ise - yazacak.
              totalValue =
                  totalValue! + (modelCalculate?.calculateValue ?? null)!;
            }
            //
            else if (totalValue.toString().substring(len - 1) == "." ||
                totalValue.toString().substring(len - 1) == "+" ||
                totalValue.toString().substring(len - 1) == "-") {
              // bir onceki deger - + veya . ise yazmayacak
            }
          } else {
            // eger bir onceki eleman operatorse ve son gelen eleman operator degil sayi ise yazdiracak.
            totalValue =
                totalValue! + (modelCalculate?.calculateValue ?? null)!;
          }
        }
        // eger eger bir onceki eleman zaten operator veya . degil sayi ise
        else {
          // son gelen eleman . ise
          if (modelCalculate?.calculateValue == ".") {
            // ve iki operator arasinda henuz hic . kullanilmadiysa . eklenir dotClik 1 yapilir
            // eger iki operatoor arasinda . varsa ikinci . eklenmez bir sey yapilmaz
            if (dotClick == 0 || dotCount == 0 || click == true) {
              dotCount = dotCount! + 1;
              dotClick = dotClick! + 1;
              click = false;
              totalValue =
                  totalValue! + (modelCalculate?.calculateValue ?? null)!;
            }
          }
          // gelen eleman . dan farkli  ise eger
          else {
            // operatorlerden biri secildiyse eger dotclik 0 lanir. bu sayede iki operator arasinda tek . kullanimini saglanmis olur
            // ve bir sonraki operator arasinda yine . kullanilmasina izin verilmis olur.
            if (modelCalculate?.calculateValue == "^" ||
                modelCalculate?.calculateValue == "/" ||
                modelCalculate?.calculateValue == "*" ||
                modelCalculate?.calculateValue == "-" ||
                modelCalculate?.calculateValue == "+") {
              dotClick = 0;
              totalValue =
                  totalValue! + (modelCalculate?.calculateValue ?? null)!;
            }
            // Operator degilse gelen eleman direkt eklenir.
            else {
              totalValue =
                  totalValue! + (modelCalculate?.calculateValue ?? null)!;
                  print("deneme");
            }
          }
        }
      }
    }
  }

  bool? lastElement() {
    if (null != totalValue) {
      int len = totalValue.toString().length;
      if (len > 0) {
        if (totalValue.toString().substring(len - 1) != "^" &&
            totalValue.toString().substring(len - 1) != "/" &&
            totalValue.toString().substring(len - 1) != "*" &&
            totalValue.toString().substring(len - 1) != "-" &&
            totalValue.toString().substring(len - 1) != "+" &&
            totalValue.toString().substring(len - 1) != ".") {
          return true;
        } else {
          return false;
        }
      }
    } else {
      return false;
    }
  }
}
