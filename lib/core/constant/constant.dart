import 'package:kidnap_detection_app/modules/kidnap_report/model/kidnap_case_model.dart';

class Constant {
  Map<int, KidnapCaseModel> kidnapCases = {};

  void Function(void Function())? updateReportList;
  void Function(void Function())? updatedkidnapDetails;
  void Function(void Function())? updatedPerson;
  void Function(void Function())? updatedCars;
}
