abstract class IModelCalculate {
  String? calculateValue;
}

class ModelCalculate implements IModelCalculate {
  @override
  String? calculateValue;
  ModelCalculate({required this.calculateValue});
}
