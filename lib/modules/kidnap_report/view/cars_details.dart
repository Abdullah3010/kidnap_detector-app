import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/constant/constant.dart';
import 'package:kidnap_detection_app/core/services/socket_io.dart';

class CarssDetails extends StatefulWidget {
  final int caseNumber;
  const CarssDetails({
    super.key,
    required this.caseNumber,
  });

  @override
  State<CarssDetails> createState() => _CarssDetailsState();
}

class _CarssDetailsState extends State<CarssDetails> {
  final SocketService sNavigation = Modular.get<SocketService>();
  final Constant constant = Modular.get<Constant>();

  @override
  void initState() {
    constant.updatedCars = setState;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("cars Details"),
      ),
      body: constant.kidnapCases[widget.caseNumber]?.cars.length == 0
          ? const Center(
              child: Text("No cars found"),
            )
          : GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
              ),
              padding: const EdgeInsets.all(10),
              children: [
                ...constant.kidnapCases[widget.caseNumber]!.cars.map(
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
