import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/kidnap_provider.dart';
import '../widgets/kidnap_widget.dart';


class KidnapCameraView extends StatefulWidget {
  const KidnapCameraView({Key? key}) : super(key: key);

  @override
  _KidnapCameraViewState createState() => _KidnapCameraViewState();
}

class _KidnapCameraViewState extends State<KidnapCameraView> {
  @override
  Widget build(BuildContext context) {
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
                  children: Provider.of<KidnapResults>(context , listen: false).images.keys.map((key) {
                    return KidnapWidget(image : Provider.of<KidnapResults>(context , listen: false).images[key]!.first);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
