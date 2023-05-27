import 'dart:async';
import 'dart:convert';
import 'dart:developer' as dev;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';
import 'package:screenshot/screenshot.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:video_player_win/video_player_win.dart';

class VideoWidget extends StatefulWidget {
  final String videoPath;
  final int id;
  VideoWidget({
    required this.videoPath,
    required this.id,
  });
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  WinVideoPlayerController? _controller;
  late IO.Socket socket;
  bool isInitialized = false;
  final SocketService service = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();
  ScreenshotController screenshotController = ScreenshotController();
  Timer? _timer;
  final double desiredFrameRate = 12;

  @override
  void initState() {
    constant.updatedVideoWidget.add(setState);
    initVideo();
    service.initSocket(context);
    super.initState();
  }

  void initVideo() async {
    try {
      _controller = WinVideoPlayerController.file(File(widget.videoPath));
      _controller!.initialize().then((value) {
        if (_controller!.value.isInitialized) {
          // _controller!.play();
          setState(() {});
        } else {
          dev.log("video file load failed");
        }
      }).catchError((e) {
        dev.log("controller.initialize() error occurs: $e");
      });
      setState(() {});
      ;
      _controller!.setLooping(false);

      _controller!.addListener(() {
        if (isInitialized == false && _controller!.value.isInitialized == true) {
          isInitialized = true;
          _controller!.setVolume(0.0);
        }
      });
    } catch (e) {
      dev.log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2 - 10,
      width: MediaQuery.of(context).size.width / 2 - 10,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: constant.cameraIdThatHaveCase == widget.id ? Colors.red : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Screenshot(
            controller: screenshotController,
            child: WinVideoPlayer(_controller!),
          ),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                    _timer?.cancel();
                  } else {
                    _controller!.play();
                    _timer = Timer.periodic(
                      Duration(milliseconds: (1000 / 12).round()),
                      (_) {
                        final position = _controller!.value.position;
                        final duration = _controller!.value.duration;
                        print("=========> $position");
                        if (position >= duration) {
                          print("Completed");
                          _timer!.cancel();
                        } else {
                          sendFrame();
                        }

                        // _videoListener();
                      },
                    );
                  }
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _timer?.cancel();

    super.dispose();
  }

  sendFrame() async {
    try {
      screenshotController.capture().then((Uint8List? image) {
        service.sendToSocket(event: 'frame', message: {
          'camera_id': widget.id,
          'frame': base64.encode(image ?? []),
        });
      }).catchError((onError) {
        print(onError);
      });
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
