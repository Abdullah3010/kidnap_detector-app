import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';

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
  final SocketService sNavigation = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();
  @override
  void initState() {
    super.initState();
    constant.updatedkidnapDetails = setState;
    sNavigation.getKidnapCaseDetails(
      caseNumber: widget.caseNumber,
    );
  }

  int framNumber = 0;
  @override
  Widget build(BuildContext context) {
    print(widget.caseNumber);
    print(constant.kidnapCases[widget.caseNumber]?.kidnapVideo.length);

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
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              constant.kidnapCases[widget.caseNumber]?.kidnapVideo.isEmpty ?? true
                  ? CircularProgressIndicator()
                  : SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      // height: 300,
                      child: Center(
                        child: Image.memory(
                          constant.kidnapCases[widget.caseNumber]!.kidnapVideo[framNumber],
                        ),
                      ),
                    ),
              Padding(
                padding: const EdgeInsets.all(30),
                child: MaterialButton(
                  color: Colors.blue,
                  onPressed: () {},
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("fuck ${constant.kidnapCases[widget.caseNumber]?.carNumber}"),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Show Persons"),
                  ),
                  MaterialButton(
                    onPressed: () {},
                    child: Text("Show cars"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
