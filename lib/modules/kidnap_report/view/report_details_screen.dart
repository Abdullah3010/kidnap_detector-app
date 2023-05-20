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

    if (constant.kidnapCases[widget.caseNumber]?.kidnapVideo.isNotEmpty ?? false) {
      Timer.periodic(
        Duration(milliseconds: 500),
        (timer) {
          if (constant.kidnapCases[widget.caseNumber]?.kidnapVideo.length == framNumber - 1) {
            timer.cancel();
          }
          setState(() {
            framNumber++;
          });
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Kidnap case ${widget.caseNumber}'),
      ),
      body: constant.kidnapCases[widget.caseNumber]?.kidnapVideo.isEmpty ?? true
          ? CircularProgressIndicator()
          : Center(
              child: Image.memory(
                constant.kidnapCases[widget.caseNumber]!.kidnapVideo[framNumber],
              ),
            ),
    );
  }
}
