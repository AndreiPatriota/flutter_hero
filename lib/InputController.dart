import 'package:flutter/material.dart';
import 'Player.dart';

double _touchAnchorX;
double _touchAnchorY;
var _moveSensitivity = 20;
Player _player;

void init(Player somePlayer)
{
    /*Stores a reference to the player object*/

    _player = somePlayer;
}

void onPanStart(DragStartDetails details)
{
  /*Routine that handles the first touch on the screen*/

  //Saves the anchor point coordinates
  _touchAnchorX = details.globalPosition.dx;
  _touchAnchorY = details.globalPosition.dy;

  //Make sure the player isn't moving
  _player.moveVertical = 0;
  _player.moveHorizontal = 0;
}

void onPanUpdate(DragUpdateDetails details)
{
  /*Routine that handles the finger sweeping on the screen
  * from the anchor point*/

  //Figures the direction of the player's horizontal movement
  if(details.globalPosition.dx < _touchAnchorX - _moveSensitivity)
  {//To the left

    _player..moveHorizontal = -1
      ..orientationChanged();
  }
  else if(details.globalPosition.dx > _touchAnchorX + _moveSensitivity)
  {//To the right

    _player..moveHorizontal = 1
      ..orientationChanged();
  }
  else
  {//Standstill

    _player..moveHorizontal = 0
      ..orientationChanged();
  }

  //Figures the direction of the player's vertical movement
  if(details.globalPosition.dy < _touchAnchorY - _moveSensitivity)
  {//To the top

    _player..moveVertical = -1
      ..orientationChanged();
  }
  else if(details.globalPosition.dy > _touchAnchorY + _moveSensitivity)
  {//To the bottom

    _player..moveVertical = 1
      ..orientationChanged();
  }
  else
  {//Standstill

    _player..moveVertical = 0
      ..orientationChanged();
  }
}

void onPanEnd(dynamic details)
{
  /*This routine handles the action of releasing the finger out of the
  * screen*/

  //Make sure the player isn't moving in any direction
  _player..moveVertical = 0
    ..moveHorizontal = 0;
}