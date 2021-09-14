import 'package:flutter/material.dart';
import 'package:flutter_hero/GameObject.dart';

class Player extends GameObject {
  //**********************Attributes**********************/

  //Movement related attributes
  int speed = 0;
  int moveHorizontal = 0;
  int moveVertical = 0;
  double radians = 0.0;
  Map angles2Radians = {
    'angle45': 0.7853981633974483,
    'angle90': 2 * 0.7853981633974483,
    'angle135': 3 * 0.7853981633974483,
    'angle180': 4 * 0.7853981633974483,
    'angle225': 5 * 0.7853981633974483,
    'angle270': 6 * 0.7853981633974483,
    'angle315': 7 * 0.7853981633974483,
  };

  double energy = 0.0; //Crystal energy

  //**********************Methods**********************/

  Player(double inScreenWidth, double inScreenHeight, String inBaseFileName,
      int inWidth, int inHeight, int inNumFrames, int inFrameSkip, inSpeed)
      : super(inScreenWidth, inScreenHeight, inBaseFileName, inWidth, inHeight,
            inNumFrames, inFrameSkip, null) {
    /*This is the constructor method*/

    this.speed = inSpeed;
  }

  @override
  void move() {
    /*This method changes the objects position according to the speed
    * and the direction*/
  }

  @override
  Widget draw() {
    /*This method draws the player object by using a Positioned
    * widget*/

    //If the object is visible, returns a Positioned widget, which
    //encapsulates an Image widget
    return this.isVisible
        ? Positioned(
            child: Transform.rotate(
              angle: this.radians,
              child: this.frames[this.frameCount],
            ),
            left: this.x,
            top: this.y,
          )
        : Container();
  }
}
