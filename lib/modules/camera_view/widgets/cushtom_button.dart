import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  String title ;
  var onTap ;
  CustomButton({Key? key , required this.title , this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.15,
          padding: EdgeInsets.all(10),
          child: MaterialButton(
            color: Colors.blue,
            onPressed: onTap,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        )
      ],
    );
  }
}
