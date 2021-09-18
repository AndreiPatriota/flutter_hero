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
AnimationController gameLooController;
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

void firstTimeInitialization(BuildContext context, State inState) {
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

  //Instantiate some objects that will provide an API to controlling
  // the graphical elements
  crystal = GameObject(screenWidth, screenHeight, 'crystal', 32, 30, 4, 6, null);
  planet = GameObject(screenWidth, screenHeight, 'planet', 64, 64, 1, 0, null);
  player = Player(screenWidth, screenHeight, 'player', 40, 34, 2, 6, 2);
  fish = [
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
    Enemy(screenWidth, screenHeight, 'fish', 48, 48, 2, 6, 1, 4),
  ];


}
