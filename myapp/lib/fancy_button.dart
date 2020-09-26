import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FancyButton extends StatelessWidget {
  FancyButton({@required this.onPressed});

  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return new RawMaterialButton (
      fillColor: Colors.deepOrange,
      splashColor: Colors.orange,
      child: Padding (
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 20,
          ),
          child: Row (
              mainAxisSize: MainAxisSize.min,
              children: const <Widget> [
                RotatedBox(
                  quarterTurns: 3,
                  child: Icon(
                    Icons.explore,
                    color: Colors.amber,
                  ),
                ),
                SizedBox(width: 8.0),
                Text (
                    "PURCHASE",
                    style: TextStyle (
                      color: Colors.white,
                    )
                )
              ]
          )
      ),
      onPressed: onPressed,
      shape: const StadiumBorder(),
    );
  }
}