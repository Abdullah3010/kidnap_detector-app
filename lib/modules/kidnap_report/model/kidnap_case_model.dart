import 'dart:typed_data';

class KidnapCaseModel {
  final int caseNumber;
  final int cameraId;
  final bool involvedPeople;
  final bool usedCar;
  final List<Uint8List> kidnapVideo = <Uint8List>[];

  KidnapCaseModel({
    required this.caseNumber,
    required this.cameraId,
    required this.involvedPeople,
    required this.usedCar,
  });
}
