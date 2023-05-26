import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/navigation/routes_names.dart';
import 'package:kidnap_detection_app/modules/kidnap_report/model/kidnap_case_model.dart';

class CaseItemWidget extends StatelessWidget {
  CaseItemWidget({super.key, required this.kidnapCaseModel});

  final KidnapCaseModel kidnapCaseModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () {
          print(kidnapCaseModel.caseNumber);
          Modular.to.pushNamed(
            AppRoutes.routes.reportDetails,
            arguments: {'case_number': kidnapCaseModel.caseNumber},
          );
          print("=====================================");
          print(kidnapCaseModel.caseNumber);
        },
        child: Row(
          children: [
            Column(
              children: [
                Text('Case Number ${kidnapCaseModel.caseNumber}'),
                Text('Camera Id ${kidnapCaseModel.cameraId}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
