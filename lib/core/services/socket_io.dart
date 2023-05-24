import 'dart:async';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../modules/camera_view/controller/kidnap_provider.dart';

class SocketService {
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

    socket.on('frame_processed', (data) {
      print(data['success']);
      if(data["success"] == 200){
      Provider.of<KidnapResults>(context , listen: false).addNewFrame(data["key"], data["frame_base64"]);
      }
    });

    socket.connect();
  }
  void sendToSocket({
    required String event,
    required dynamic message,
  }) {
    socket.emit(event, message);
  }

  void dispose() {
    socket.disconnect();
    socket.dispose();
  }
}
