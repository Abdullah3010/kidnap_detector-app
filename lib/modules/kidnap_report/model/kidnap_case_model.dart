import 'dart:typed_data';

class KidnapCaseModel {
  int caseNumber;
  int cameraId;
  String caseTime ;
  String? kidnapVideoLink ;
  String? licensePlate ;
  String? carImage ;
  String? licenseImage ;
  bool? involvedPeople;
  int numberOfPersons ;
  bool? usedCar;
  String? carNumber;
  List<String> kidnapVideo = <String>[];
  List<String> persons = <String>[];
  List<String> cars = <String>[];

  KidnapCaseModel({
    required this.caseNumber,
    required this.cameraId,
    required this.caseTime,
    this.involvedPeople,
    required this.numberOfPersons ,
    this.carNumber,
    this.usedCar,
    this.licensePlate,
  });
}
