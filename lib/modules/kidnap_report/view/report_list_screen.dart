import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/widget/case_item_widget.dart';

class ReportListScrren extends StatefulWidget {
  const ReportListScrren({Key? key}) : super(key: key);

  @override
  _ReportListScrrenState createState() => _ReportListScrrenState();
}

class _ReportListScrrenState extends State<ReportListScrren> {
  final SocketService sNavigation = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();

  @override
  void initState() {
    constant.updateReportList = setState;
    sNavigation.initSocket();
    sNavigation.getAllKidnapCases();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("object ${constant.kidnapCases.length}");
    return Scaffold(
      appBar: AppBar(
        title: Text('ReportListScrren'),
      ),
      body: ListView.builder(
        itemCount: constant.kidnapCases.values.length,
        itemBuilder: (context, index) {
          return CaseItemWidget(
            kidnapCaseModel: constant.kidnapCases.values.elementAt(index),
          );
        },
      ),
    );
  }
}
