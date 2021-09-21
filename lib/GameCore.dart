import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'GameObject.dart';
import 'InputController.dart' as InputController;
import 'Enemy.dart';
import 'Player.dart';

//Global variables
State state;
var random = new Random();
var score = 0;
double screenWidth;
double screenHeight;
AnimationController gameLoopController;
Animation gameLoopAnimation;
GameObject crystal;
List<Enemy> fish;
List<Enemy> robots;
List<Enemy> aliens;
List<Enemy> asteroids;
Player player;
GameObject planet;
List<GameObject> explosions = [];
AudioCache audioCache;

void firstTimeInitialization(BuildContext context, dynamic inState) {
  /*This function initializes the global objects the will be used to
  * control the game*/

  state = inState; //Saves a GameScreenSate object reference

  //Initiates the MP3 API
  audioCache = new AudioCache();
  audioCache.loadAll([
    'sounds/delivery.mp3',
    'sounds/explosions.mp3',
    'sounds/fill.mp3',
    'sounds/thrust.mp3'
  ]);

  //Gets the device's screen dimensions
  screenWidth = MediaQuery.of(context).size.width;
  screenHeight = MediaQuery.of(context).size.height;

  //Instantiate some objects that will provide an API for controlling
  // the sprites
  crystal =
      GameObject(screenWidth, screenHeight, 'crystal', 32, 30, 4, 6, null);
  planet = GameObject(screenWidth, screenHeight, 'planet', 64, 64, 1, 0, null);
  player = Player(screenWidth, screenHeight, 'player', 40, 34, 2, 6, 2);
  fish = [
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
  ];
  robots = [
    Enemy(screenWidth, screenHeight, 'robot', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'robot', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'robot', 48, 48, 2, 6, 1, 4),
  ];
  aliens = [
    Enemy(screenWidth, screenHeight, 'alien', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'alien', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'alien', 48, 48, 2, 6, 1, 4),
  ];
  asteroids = [
    Enemy(screenWidth, screenHeight, 'asteroid', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'asteroid', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'asteroid', 48, 48, 2, 6, 1, 4),
  ];

  //Instantiate an AnimationController and an Animation
  // objects, respectively
  gameLoopController = AnimationController(
      vsync: inState, duration: Duration(microseconds: 1000));
  gameLoopAnimation = Tween(begin: 0, end: 17).animate(
      CurvedAnimation(parent: gameLoopController, curve: Curves.linear));

  //Adds the appropriate listeners to the Animation object:
  // - the change of state listener;
  // - the tick listener
  gameLoopAnimation.addStatusListener((status) {
    /*Runs everytime the status of the animation changes*/

    //Restarts the animation sequence when it finishes, so
    // it runs continuously
    if(status == AnimationStatus.completed){
      gameLoopController..reset()
                       ..forward();
    }

  });
  gameLoopAnimation.addListener(gameLoop);


  resetGame(resetEnemies: true);
  InputController.init(player);
  gameLoopController.forward(); //Starts the game loop
}

void resetGame({bool resetEnemies = false})
{
  /*Resets the game, by setting the positions of all moving
  * objets to some initial default values*/

  //Moves the player to the initial position
  player..energy = 0.0
        ..x = (screenWidth / 2) - (player.width /2)
        ..y = screenHeight - player.height - 24
        ..moveHorizontal = 0
        ..moveVertical = 0
        ..orientationChanged();

  //Resets the position of the crystal object
  crystal.y = 34.0;
  randomlyPositionObject(crystal);

  //Resets the position of the planet object
  planet.y = screenHeight - planet.height - 10;
  randomlyPositionObject(planet);

  //Verifies if the position of the enemies will need
  // to the reset
  if(resetEnemies)
  {
    //Defines the initial X position of the enemies
    var xValsFish = [70.0, 192.0, 312.0];
    var xValsRobots = [64.0, 192.0, 320.0];
    var xValsAliens = [44.0, 192.0, 340.0];
    var xValsAstetoids = [24.0, 192.0, 360.0];

    //Loops through the lists of enemies setting their x and y
    // position. Also sets them visible
    for(var idx = 0; idx < 3; idx++)
    {
        fish[idx]
          ..x = xValsFish[idx]
          ..y = fish[idx].y + 110
          ..isVisible = true;
        robots[idx]
          ..x = xValsRobots[idx]
          ..y = robots[idx].y + 120
          ..isVisible = true;
        aliens[idx]
          ..x = xValsAliens[idx]
          ..y = aliens[idx].y + 130
          ..isVisible = true;
        asteroids[idx]
         ..x = xValsAstetoids[idx]
         ..y = asteroids[idx].y + 140
         ..isVisible = true;
    }
  }

  explosions = []; //Clears the explosions
  planet.isVisible = true;//Makes the player visible

}

void gameLoop()
{
  /*Runs everytime there is a tick, i.e, every 16,667ms, so there
  * will be, approximately, 60 rebuilds per second*/

  crystal.animate();//Updates crystal frame

  //Updates and moves all the enemies, as well as the player
  for(var idx = 0; idx < 3; idx++)
  {
    fish[idx]..move()..animate();
    robots[idx]..move()..animate();
    aliens[idx]..move()..animate();
    asteroids[idx]..move()..animate();
  }
  player..move()..animate();

  //Updates the explosions frames
  for(GameObject explosion in explosions)
  {
    explosion.animate();
  }

  //Checks for collision between the player and planet
  // or between the player and the crystal
  if(player.collidesWith(crystal))
  {

    if(player.isEmpty) audioCache.play('fill.mp3');//Plays the sound in first contact
    player.suckEnergy();//Suck energy
    if(player.isFull) randomlyPositionObject(crystal);//When full, moves the crystal away

  }
  else if(player.collidesWith(planet))
  {

    if(player.isFull) audioCache.play('deliver.mp3');//Plays the sound in first contact
    player.deliverEnergy();//Deliver energy
    if(player.finishedDelivery) explodeAllEnemies();//When empty, explode the enemies

  }
  else
  {
    if(player.energy > 0 && player.energy < 1) player.energy = 0;
  }

  //Checks for collisions between the player and the obstacles
  for(var idx = 0; idx < 3; idx++)
  {
    //Verifies if any collision has happened
    if(player.collidesWith(fish[idx]) || player.collidesWith(robots[idx])
       || player.collidesWith(aliens[idx]) || player.collidesWith(asteroids[idx]))
    {
      
      audioCache.play('explosion.mp3');//Play the explosion sound
      player.isVisible = false;//Takes the player out of the screen

      //Appends an explosion, at the same position of the player,
      // to the explosions list
      explosions.add(GameObject(screenWidth, screenHeight,
                                'explosion', 50, 50, 5, 4,
                                (){resetGame(resetEnemies: false);})
                                ..x = player.x
                                ..y = player.y);
      score = (score - 50) > 0 ? score - 50 : 0;//Deducts 50 points from the score

    }
  }

  state.setState(() {});//Rebuilds the GameScreen
}


void randomlyPositionObject(GameObject someObject)
{
  /*This function randomly places a GameObject instance on the screen
  * , making sure that it will not overlap with the player*/

  //Assigns a new random X position to the object
  someObject.x = (random.nextInt(screenWidth.toInt() - someObject.width)).toDouble();

  //In case there is overlap with player, a recursive call is triggered
  if(player.collidesWith(someObject)) randomlyPositionObject(someObject);
}

void explodeAllEnemies()
{
  /*This function explodes all the enemies on the screen
  * and increases the score by 100*/

  //Plays the explosion track, and increases the score by 100
  var callback = (){resetGame(resetEnemies: true);};
  audioCache.play('explosion.mp3');
  score += 100;

  //Loops through the lists of enemies to explode them one by one
  for(var idx = 0; idx < 3; idx++)
  {
    //Makes the enemies invisible
    fish[idx].isVisible = false;
    robots[idx].isVisible = false;
    aliens[idx].isVisible = false;
    asteroids[idx].isVisible = false;

    //Appends one explosion to the list of explosions for every single
    // enemy on the exact same location it used to be
    explosions.add(GameObject(screenWidth, screenHeight,
        'explosion', 50, 50, 5, 4, callback)
      ..x = fish[idx].x
      ..y = fish[idx].y);
    explosions.add(GameObject(screenWidth, screenHeight,
        'explosion', 50, 50, 5, 4, callback)
      ..x = robots[idx].x
      ..y = robots[idx].y);
    explosions.add(GameObject(screenWidth, screenHeight,
        'explosion', 50, 50, 5, 4, callback)
      ..x = aliens[idx].x
      ..y = aliens[idx].y);
    explosions.add(GameObject(screenWidth, screenHeight,
        'explosion', 50, 50, 5, 4, callback)
      ..x = asteroids[idx].x
      ..y = asteroids[idx].y);
  }

  player.finishedDelivery = false;
}

