import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/view/cars_details.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/view/persons_details.dart';

import '../../../core/functions/base64_to_uint.dart';
import '../../camera_view/controller/kidnap_provider.dart';
import '../../camera_view/widgets/cushtom_button.dart';
import '../../camera_view/widgets/error_image.dart';
import '../../camera_view/widgets/licence_view.dart';
import '../../camera_view/widgets/video_widget.dart';

class ReportDetailsScreen extends StatefulWidget {
  ReportDetailsScreen({
    super.key,
    required this.caseNumber,
  });

  final int caseNumber;

  @override
  _ReportDetailsScreenState createState() => _ReportDetailsScreenState();
}

class _ReportDetailsScreenState extends State<ReportDetailsScreen> {
  // final SocketService sNavigation = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();
  bool person = false, licencePlat = false, carImage = false;
  @override
  void initState() {
    super.initState();
    constant.updatedkidnapDetails = setState;
    // sNavigation.getKidnapCaseDetails(
    //   caseNumber: widget.caseNumber,
    // );
  }

  int framNumber = 0;
  @override
  Widget build(BuildContext context) {
    if (framNumber == 0) {
      if (constant.kidnapCases[widget.caseNumber]?.kidnapVideo.isNotEmpty ?? false) {
        Timer.periodic(
          Duration(milliseconds: 50),
          (timer) {
            print("Timmmer =======> $framNumber");
            print("Timmmer =======> ${constant.kidnapCases[widget.caseNumber]?.kidnapVideo.length}");
            if ((constant.kidnapCases[widget.caseNumber]?.kidnapVideo.length ?? 0) - 1 == framNumber) {
              timer.cancel();
            } else {
              setState(() {
                framNumber++;
              });
            }
          },
        );
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kidnap case ${widget.caseNumber}'),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 4,
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getCart(
                        leading: "Camera Id : ${constant.kidnapCases[widget.caseNumber]?.cameraId}",
                        trailing: constant.kidnapCases[widget.caseNumber]!.caseTime.toString(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: MediaQuery.of(context).size.height / 2,
                            margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration:
                                BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ]),
                            child: /*constant.kidnapCases[widget.caseNumber]?.kidnapVideo.isEmpty ?? false ?
                            Center(
                                child: CircularProgressIndicator(
                                )
                            )
                                :
                                */
                                SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: VideoWidget(
                                videoPath: constant.kidnapCases[widget.caseNumber]!.kidnapVideoLink.toString(),
                                VideoId: 5,
                                height: MediaQuery.of(context).size.height / 3,
                                width: MediaQuery.of(context).size.width / 3,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomButton(
                                    title: "Play Video",
                                    onTap: () {},
                                  ),
                                  CustomButton(
                                    title: "Show Persons",
                                    onTap: () {
                                      setState(() {
                                        person = true;
                                      });
                                    },
                                  ),
                                  CustomButton(
                                    title: "Show Licence number",
                                    onTap: () {
                                      setState(() {
                                        licencePlat = true;
                                      });
                                    },
                                  ),
                                  CustomButton(
                                    title: "Show car",
                                    onTap: () {
                                      setState(() {
                                        carImage = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      carImage == true || licencePlat == true ? Divider() : Container(),
                      getCart(
                        leading: "Licence Number",
                        trailing: constant.kidnapCases[widget.caseNumber]!.licensePlate.toString(),
                      ),
                      carImage == true || licencePlat == true
                          ? LicenceWidget(
                              isCarImage: carImage,
                              licencePlat: licencePlat,
                              carImage: constant.kidnapCases[widget.caseNumber]!.carImage,
                              licenceImage: constant.kidnapCases[widget.caseNumber]!.licenseImage,
                              height: MediaQuery.of(context).size.height / 4,
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          person == true ? VerticalDivider() : Container(),
          person == true ? PersonsDetails(caseNumber: widget.caseNumber) : Container(),
        ],
      ),
    );
  }

  getCart({required String leading, required String trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            leading,
            style: GoogleFonts.acme(fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            trailing,
            style: GoogleFonts.acme(fontSize: 20),
          ),
        ),
      ],
    );
  }
}
