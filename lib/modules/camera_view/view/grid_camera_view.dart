import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import '../../../core/navigation/routes_names.dart';
import '../../../core/services/socket_io.dart';
import '../widgets/video_widget.dart';

class GridCameraView extends StatefulWidget {
  GridCameraView({Key? key}) : super(key: key);

  @override
  _GridCameraViewState createState() => _GridCameraViewState();
}

class _GridCameraViewState extends State<GridCameraView> {
  List<String> listOfVideos = [];
  List<VideoPlayerController> controllers = [];
  // final SocketService service = Modular.get<SocketService>();

  @override
  void initState() {
    getVideos();
    // service.initSocket(context);
    // Modular.to.navigate(AppRoutes.routes.kidnapCamerView);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kidnap Detection",
          style: GoogleFonts.acme(),
        ),
      ),
      floatingActionButton: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      "Kidnap Cases",
                      style: GoogleFonts.acme(fontSize: 15),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
                //   content: Container(
                //     width: MediaQuery.of(context).size.width / 3,
                //     height: MediaQuery.of(context).size.height * 0.7,
                //     child: SingleChildScrollView(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: service.constant.kidnapCases.values.map((kidnapCaseModel) {
                //           return InkWell(
                //             onTap: () {
                //               print(kidnapCaseModel.caseNumber);
                //               Modular.to.pushNamed(
                //                 AppRoutes.routes.reportDetails,
                //                 arguments: {'case_number': kidnapCaseModel.caseNumber},
                //               );
                //             },
                //             child: Container(
                //               margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //               padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                //               decoration:
                //                   BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.withOpacity(0.2),
                //                   spreadRadius: 5,
                //                   blurRadius: 7,
                //                   offset: Offset(0, 3), // changes position of shadow
                //                 ),
                //               ]),
                //               child: Column(
                //                 children: [
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //                     children: [
                //                       Text(
                //                         "Cases Id : ${kidnapCaseModel.caseNumber}",
                //                         style: GoogleFonts.acme(fontSize: 15),
                //                       ),
                //                       Text(
                //                         kidnapCaseModel.caseTime.toString(),
                //                         style: GoogleFonts.acme(fontSize: 15),
                //                       ),
                //                     ],
                //                   ),
                //                   Row(
                //                     mainAxisAlignment: MainAxisAlignment.start,
                //                     children: [
                //                       Text(
                //                         "Camera Id :  ${kidnapCaseModel.cameraId}",
                //                         style: GoogleFonts.acme(fontSize: 15),
                //                       ),
                //                     ],
                //                   ),
                //                   kidnapCaseModel.licensePlate != null
                //                       ? Row(
                //                           mainAxisAlignment: MainAxisAlignment.start,
                //                           children: [
                //                             Text(
                //                               "Licence plate :  ${kidnapCaseModel.licensePlate}",
                //                               style: GoogleFonts.acme(fontSize: 15),
                //                             ),
                //                           ],
                //                         )
                //                       : Container(),
                //                 ],
                //               ),
                //             ),
                //           );
                //         }).toList(),
                //       ),
                //     ),
                //   ),
                //
              );
            },
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 50,
          height: 50,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: Colors.blue),
          child: Icon(
            Icons.file_copy,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(5),
        child: Wrap(
          alignment: WrapAlignment.start,
          direction: Axis.horizontal,
          spacing: 5,
          runSpacing: 5,
          runAlignment: WrapAlignment.start,
          children: listOfVideos.map((videoPath) {
            index++;
            return VideoWidget(
              videoPath: videoPath,
              VideoId: index,
              height: MediaQuery.of(context).size.height / 2 - 40,
              width: MediaQuery.of(context).size.width / 2 - 10,
            );
          }).toList(),
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
