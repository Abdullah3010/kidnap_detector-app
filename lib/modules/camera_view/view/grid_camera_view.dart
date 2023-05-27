import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:video_player/video_player.dart';
import '../../../core/navigation/routes_names.dart';
import '../widgets/video_widget.dart';

class GridCameraView extends StatefulWidget {
  const GridCameraView({Key? key}) : super(key: key);

  @override
  _GridCameraViewState createState() => _GridCameraViewState();
}

class _GridCameraViewState extends State<GridCameraView> {
  List<String> listOfVideos = [];
  List<VideoPlayerController> controllers = [];

  @override
  void initState() {
    getVideos();
    // Modular.to.navigate(AppRoutes.routes.kidnapCamerView);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Wrap(
                  alignment: WrapAlignment.start,
                  direction: Axis.horizontal,
                  spacing: 5,
                  runSpacing: 5,
                  runAlignment: WrapAlignment.spaceAround,
                  children: listOfVideos.map((videoPath) {
                    index++;
                    return VideoWidget(
                      videoPath: videoPath,
                      id: index,
                    );
                  }).toList(),
                ),
              ),
            ),
            Container(
              child: Column(
                children: [],
              ),
            )
          ],
        ),
      ),
    );
  }

  getVideos() async {
    final Map<String, dynamic> assets = jsonDecode(await rootBundle.loadString('AssetManifest.json'));
    assets.forEach(
      (key, value) {
        if (value[0].toString().contains("video") == true) {
          print("Video ====> ${value[0]}");
          setState(() {
            listOfVideos.add(value[0]);
          });
        }
      },
    );
  }

  getFrames() async {
    final Map<String, dynamic> assets = jsonDecode(await rootBundle.loadString('AssetManifest.json'));
    assets.forEach((key, value) {
      List path = value.toString().split("/");
      if (path.length == 4) {
        //listOfVideos[path[2]]?.add(value[0]);
      }
    });
  }
}
