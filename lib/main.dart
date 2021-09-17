import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'InputController.dart' as InputController;
import 'GameCore.dart' as gcore;

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

class GameScreen extends StatefulWidget {
  /*Initial screen*/

  @override
  GameScreenState createState() => GameScreenState();
}

class GameScreenState extends State with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    /*This is the build method*/

    //Initializes global parameters the first time it runs
    if (gcore.gameLoopController == null)
      gcore.firstInitialization(context, this);

    //Assembles a list of Positioned widgets that will hold the graphics
    //displayed on the main screen
    List<Widget> stackChildren = [
      Positioned(
          //Background image
          child: Container(
        width: gcore.screenWidth,
        height: gcore.screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover)),
      )),
      Positioned(
        //Score
        child: Text(
          'Score: ${gcore.score.toString().padLeft(4, '0')}',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
        ),
        top: 2,
        left: 4,
      ),
      Positioned(
        //Linear progress bar
        child: LinearProgressIndicator(
          value: gcore.player.energy,
          backgroundColor: Colors.white,
          valueColor: AlwaysStoppedAnimation(Colors.red),
        ),
        top: 2,
        left: 120,
        width: gcore.screenWidth - 124,
        height: 22,
      ),
      gcore.crystal.draw()
    ];

    return Container();
  }
}
