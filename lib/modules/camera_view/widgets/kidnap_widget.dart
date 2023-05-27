import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class KidnapWidget extends StatefulWidget {
  final String image;
  KidnapWidget({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  State<KidnapWidget> createState() => _KidnapWidgetState();
}

class _KidnapWidgetState extends State<KidnapWidget> {
  int index = 0;
  String currentImage = "assets/kidnap_videos/2/ezgif-frame-001.jpg";
  @override
  void initState() {
    super.initState();
    /*
    Timer.periodic(const Duration(milliseconds: 50), (Timer t){
      if(index < widget.images.length ){
        setState(() {
          currentImage = widget.images[index] ;
        });
        index ++ ;
      }
    });
     */
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: MediaQuery.of(context).size.height / 2 - 10,
        width: MediaQuery.of(context).size.width / 2 - 10,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ]),
        child: Image.memory(
          ImageFromBase64String(widget.image),
          fit: BoxFit.cover,
          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info,
                    size: 40,
                  ),
                  SizedBox(
                    height: 5,
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Video unavailable",
                        style: TextStyle(fontFamily: "Tajawal"),
                      ),
                      Text(
                        "Something went wrong",
                        style: TextStyle(fontFamily: "Tajawal"),
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Uint8List ImageFromBase64String(String base64String) {
    return Base64Decoder().convert(base64String);
  }
}
