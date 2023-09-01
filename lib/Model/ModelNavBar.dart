import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_core/src/get_main.dart';

abstract class IModelNavBar {
  bool? isClickNavButton;
}

class ModelNavBar implements IModelNavBar {
  @override
  bool? isClickNavButton;
  ModelNavBar({required this.isClickNavButton});
}
