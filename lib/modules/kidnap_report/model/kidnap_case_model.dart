import 'dart:typed_data';

class KidnapCaseModel {
  int caseNumber;
  int cameraId;
  bool? involvedPeople;
  bool? usedCar;
  String? carNumber;
  List<Uint8List> kidnapVideo = <Uint8List>[];

  KidnapCaseModel({
    required this.caseNumber,
    required this.cameraId,
    this.involvedPeople,
    this.carNumber,
    this.usedCar,
  });
}
