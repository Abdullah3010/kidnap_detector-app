import 'dart:async';

import 'package:provider/provider.dart';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/model/kidnap_case_model.dart';
import 'package:msgpack_dart/msgpack_dart.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../modules/camera_view/controller/kidnap_provider.dart';

class SocketService {
  final Constant constant = Modular.get<Constant>();
  late IO.Socket socket;
  bool init = false;
  Future<void> initSocket(context) async {
    socket = IO.io('http://localhost:5000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket.onConnect((_) {
      print('connected to server');
    });

    socket.on('my_response', (data) {
      print(data);
    });

    socket.on(
      'Kidnap_case',
      (data) {
        constant.kidnapCases.addAll({
          data['Case number']: KidnapCaseModel(
            caseNumber: data['Case number'],
            cameraId: data['Camera id'],
            carNumber: data['Car license'],
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

    socket.on(
      'show_people',
      (data) {
        // print("===============> ${data['frame']}");
        var frame = deserialize(data['people']);
        constant.kidnapCases[data['case_number']]?.persons.add(frame);
        print("===============> 1${constant.kidnapCases[data['case_number']]}");
        // print("===============> 2${frame.lengt}");
        constant.updatedPerson?.call(() {});
      },
    );

    socket.on(
      'show_cars',
      (data) {
        var frame = deserialize(data['people']);
        constant.kidnapCases[data['case_number']]?.cars.add(frame);
        constant.updatedCars?.call(() {});
      },
    );

    socket.on('Kidnap_detected', (data) {
      print(data);
      constant.cameraIdThatHaveCase = data["camera_id"];
      constant.updatedVideoWidget.forEach((element) {
        element?.call(() {});
      });
    });

    socket.on('frame_processed', (data) {
      if (data["success"] == 200) {
        Provider.of<KidnapResults>(context, listen: false).addNewFrame(data["key"], data["frame_base64"]);
      }
    });

    socket.connect();
  }

  void getAllKidnapCases() {
    socket.emit('get_reported_cases');
  }

  void getKidnapCaseDetails({
    required int caseNumber,
  }) {
    socket.emit('play_video', caseNumber);
  }

  void showPepole({
    required int caseNumber,
  }) {
    socket.emit('show_people', caseNumber);
  }

  void showCars({
    required int caseNumber,
  }) {
    socket.emit('show_cars', caseNumber);
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
