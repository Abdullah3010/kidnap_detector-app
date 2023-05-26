import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';

class PersonsDetails extends StatefulWidget {
  final int caseNumber;
  const PersonsDetails({
    super.key,
    required this.caseNumber,
  });

  @override
  State<PersonsDetails> createState() => _PersonsDetailsState();
}

class _PersonsDetailsState extends State<PersonsDetails> {
  final SocketService sNavigation = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: constant.kidnapCases[widget.caseNumber]?.persons.length == 0
          ? const Center(
              child: Text("No persons found"),
            )
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              padding: const EdgeInsets.all(10),
              children: [
                ...constant.kidnapCases[widget.caseNumber]!.persons.map(
                  (e) {
                    return Container(
                      width: 100,
                      height: 100,
                      padding: const EdgeInsets.all(10),
                      child: Image.memory(
                        e,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
    );
  }
}
