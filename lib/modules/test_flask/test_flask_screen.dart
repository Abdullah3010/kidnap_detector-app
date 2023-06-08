import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';
import 'package:kidnap_detection_app/core/theme/app_theme.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

class TestFlaskScreen extends StatefulWidget {
  @override
  _TestFlaskScreenState createState() => _TestFlaskScreenState();
}

class _TestFlaskScreenState extends State<TestFlaskScreen> {
  // final SocketService sNavigation = Modular.get<SocketService>();
  late final Dio dio;
  dynamic image;

  @override
  void initState() {
    // sNavigation.initSocket(context);
    dio = Dio();
    super.initState();
  }

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
            onPressed: () async {
              // print("object");
              // sNavigation.sendToSocket(
              //   event: 'get_reported_cases',
              // );
              // print("object1 ${sNavigation.socket.id}");
              //! send image to flask
              // File imageFile = File('assets/images/test.jpg'); // Replace with the actual path to your image file
              // await uploadImage(imageFile);
              //! get image from flask
              await getImage();
            },
            child: Container(
              width: 200,
              height: 100,
              color: primaryColor,
              child: Center(child: Text("TestFlaskScreen")),
            ),
          ),
          if (image != null)
            Center(
              child: Image.memory(image),
            ),
        ],
      ),
    );
  }

  Future<void> getImage() async {
    String url = 'http://127.0.0.1:5000/api/get_image';
    try {
      Response response = await dio.get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
        ),
      );
      // print(response.data);
      setState(() {
        image = response.data;
      });
    } catch (e) {
      print('Error retrieving image: $e');
    }
  }

  Future<void> uploadImage(File imageFile) async {
    String url = 'http://127.0.0.1:5000/api/upload'; // Replace with your API endpoint

    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(
        url,
        data: formData,
      );

      if (response.statusCode == 200) {
        // Image upload success
        print('Image uploaded successfully');
      } else {
        // Image upload failed
        print('Image upload failed');
      }
    } catch (e) {
      // Handle any errors
      print('Error uploading image: $e');
    }
  }

  // Future<String> getImageBase64(String imagePath) async {
  //   ByteData imageData = await rootBundle.load(imagePath);
  //   List<int> imageBytes = imageData.buffer.asUint8List();
  //   String base64Image = base64Encode(imageBytes);
  //   return base64Image;
  // }

  // // send a video frame to the server
  // void sendFrame(List<int> frameBytes) {
  //   // encode the frame bytes as a base64 string
  //   String frameData = base64.encode(frameBytes);

  //   // emit the 'frame' event with the base64-encoded frame data
  //   socket.emit('frame', [frameData]);
  // }
}
