import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';
import 'package:kidnap_detection_app/core/theme/app_theme.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class TestFlaskScreen extends StatefulWidget {
  @override
  _TestFlaskScreenState createState() => _TestFlaskScreenState();
}

class _TestFlaskScreenState extends State<TestFlaskScreen> {
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    
  }

  final SocketService sNavigation = Modular.get<SocketService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TestFlaskScreen'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            onPressed: () {
              print("object");
              // Constants.socketService.sendMessage('message');
              getImageBase64('assets/icons/adwaa.png').then((value) {
                // print(value);
                socket.emit('frame', {'frame': value, 'camera_id': 23});
              });
              // socket.emit('my_event', {'arg1': 10, 'arg2': 30});
            },
            child: Container(
              width: 200,
              height: 100,
              color: primaryColor,
              child: Center(child: Text("TestFlaskScreen")),
            ),
          ),
          Center(
            child: Text('TestFlaskScreen is working'),
          ),
        ],
      ),
    );
  }

  Future<String> getImageBase64(String imagePath) async {
    ByteData imageData = await rootBundle.load(imagePath);
    List<int> imageBytes = imageData.buffer.asUint8List();
    String base64Image = base64Encode(imageBytes);
    return base64Image;
  }

  // send a video frame to the server
  void sendFrame(List<int> frameBytes) {
    // encode the frame bytes as a base64 string
    String frameData = base64.encode(frameBytes);

    // emit the 'frame' event with the base64-encoded frame data
    socket.emit('frame', [frameData]);
  }
}
