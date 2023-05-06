import 'dart:async';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
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

    socket.on('my_response', (data) {
      print(data);
    });
    socket.on('frame_processed', (data) {
      print(data['success']);
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
