import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'InputController.dart' as InputController;
import 'GameCore.dart';

/*This is the game entry point*/
void main() => runApp(FlutterHero());


class FlutterHero extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    /*This is the build method*/

    //Activates Android's soft navigation buttons
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    //Return the MaterialApp widget
    return MaterialApp(
      title: 'FlutterHero',
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
