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
List fish;
List robots;
List aliens;
List asteroids;
Player player;
GameObject planet;
var explosions = [];
AudioCache audioCache;

void firstTimeInitialization(BuildContext context, dynamic inState) {
  /*This function initializes the global objects in this module*/

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
  // the graphical elements
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

  //Instantiate a AnimationController and a Animation
  // objects, respectively
  gameLoopController = AnimationController(
      vsync: inState, duration: Duration(microseconds: 1000));
  gameLoopAnimation = Tween(begin: 0, end: 17).animate(
      CurvedAnimation(parent: gameLoopController, curve: Curves.linear));

  //Adds the appropriate listeners to the Animation object:
  // - the end change of state listeners;
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


  resetGame(true);
  InputController.init(player);
  gameLoopController.forward(); //Starts the game loop
}

void resetGame(bool bool) {}

void gameLoop(){}
