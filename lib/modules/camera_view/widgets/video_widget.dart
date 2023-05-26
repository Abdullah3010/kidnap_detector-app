import 'dart:async';
import 'dart:developer' as dev;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/services/socket_io.dart';


class VideoWidget extends StatefulWidget{
  String videoPath = "";
  VideoWidget({required this.videoPath});
  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {

  VideoPlayerController? _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late IO.Socket socket;
  bool isInitialized = false ;
  final SocketService service = Modular.get<SocketService>();

  @override
  void initState() {
    _controller = VideoPlayerController.asset(widget.videoPath);
    _initializeVideoPlayerFuture = _controller!.initialize();
    _controller!.setLooping(false);
    _controller!.addListener(() {
      if(isInitialized == false && _controller!.value.isInitialized == true){
        isInitialized = true ;
        _controller!.setVolume(0.0);
        _controller!.play();
      }
      sendFrame();
    });
    /*Timer.periodic(const Duration(milliseconds: 50), (Timer t){
      sendFrame();
    });*/
    service.initSocket(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2 - 10,
      width: MediaQuery.of(context).size.width / 2 - 10,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ]
      ),
      child: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Center(
                  child: AspectRatio(
                    aspectRatio: _controller!.value.aspectRatio,
                    child: VideoPlayer(
                        _controller!
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          Center(
            child: InkWell(
              onTap: () {
                setState(() {
                  if (_controller!.value.isPlaying) {
                    _controller!.pause();
                  } else {
                    _controller!.play();
                  }
                });
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
  sendFrame() async{
    if(_controller!.value.isPlaying == true){
      try{
        Duration duration = _controller!.value.position;
        //var image = await ExportVideoFrame.exportImageBySeconds(File(widget.videoPath), duration, pi / 2);
        //List<int> frameBytes =image.readAsBytesSync();
        //String frameData = base64.encode(frameBytes);
        //service.sendToSocket(event: 'frame', message: [frameData]);
      }catch (e){
        dev.log(e.toString());
      }
    }
  }
}

