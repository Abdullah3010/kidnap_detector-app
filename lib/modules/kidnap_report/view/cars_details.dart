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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
