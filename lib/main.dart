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
      gcore.firstTimeInitialization(context, this);

    //Starts assembling the stack of graphical objects with the static
    // elements that will populate the game screen
    List<Widget> stackChildren = [
      Positioned(
          //Background image
          child: Container(
        width: gcore.screenWidth,
        height: gcore.screenHeight,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/background.png'), fit: BoxFit.cover)),
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
        //Energy bar
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
      gcore.crystal.draw() //Crystal
    ];

    //Appends the obstacle objects to the stack
    for (int i = 0; i < 3; i++)
    {
      stackChildren.add(gcore.fish[i].draw());
      stackChildren.add(gcore.robots[i].draw());
      stackChildren.add(gcore.aliens[i].draw());
      stackChildren.add(gcore.asteroids[i].draw());
    }

    //Appends the planet and the player objects to the stack
    stackChildren.add(gcore.planet.draw());
    stackChildren.add(gcore.player.draw());

    //Appends the explosion objects to the stack
    for (var explosion in gcore.explosions)
    {
      stackChildren.add(explosion.draw());
    }

    //Returns a Scaffold widget that will use the stack
    return Scaffold(
      body: GestureDetector(
        onPanStart: InputController.onPanStart,
        onPanUpdate: InputController.onPanUpdate,
        onPanEnd: InputController.onPanEnd,
        child: Stack(children: stackChildren),
      ),
    );
  }
}
