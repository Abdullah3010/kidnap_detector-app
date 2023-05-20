import 'dart:async';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/model/kidnap_case_model.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final Constant constant = Modular.get<Constant>();
  late IO.Socket socket;
  bool init = false;
  Future<void> initSocket() async {
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('connected to server');
    });

    socket.on(
      'Kidnap_case',
      (data) {
        constant.kidnapCases.addAll({
          data['Case number']: KidnapCaseModel(
            caseNumber: data['Case number'],
            cameraId: data['Camera id'],
            involvedPeople: data['Involved people'],
            usedCar: data['Used car'],
          ),
        });
        constant.updateReportList?.call(() {});
      },
    );

    socket.on(
      'video_frame',
      (data) {
        // print("===============> ${data['frame']}");
        var frame = deserialize(data['frame']);
        constant.kidnapCases[data['case_number']]?.kidnapVideo.add(frame);
        print("===============> 1${constant.kidnapCases[data['case_number']]}");
        // print("===============> 2${frame.lengt}");
        constant.updatedkidnapDetails?.call(() {});
      },
    );

    socket.on('frame_processed', (data) {
      print(data['success']);
    });

    socket.connect();
  }

  void getAllKidnapCases() {
    socket.emit('get_reported_cases');
  }

  void getKidnapCaseDetails({
    required int caseNumber,
  }) {
    socket.emit('get_case_details', caseNumber);
  }

  void sendToSocket({
    required String event,
    dynamic message,
  }) {
    socket.emit(event, message);
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}
