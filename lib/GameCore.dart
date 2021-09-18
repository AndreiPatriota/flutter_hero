import 'package:flutter/cupertino.dart';
import 'package:flutter_hero/Enemy.dart';
import 'package:flutter_hero/GameObject.dart';
import 'package:flutter_hero/Player.dart';

var gameLoopController;
var screenWidth = 0.0;
var screenHeight = 0.0;
var score = 0;
Player player;
GameObject crystal, planet;
List<Enemy> fish;
List<Enemy> robots;
List<Enemy> aliens;
List<Enemy> asteroids;
List<GameObject> explosions;

void firstInitialization(BuildContext context, dynamic widget){}