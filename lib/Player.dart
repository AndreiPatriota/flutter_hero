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

  void move() {
    /*This method changes the objects position according to the speed
    * and the direction*/

    //Accounts for the horizontal movement, to the left and to the right,
    //making sure it will not cross the rightmost and leftmost borders
    if (this.x > 0 && this.moveHorizontal == -1) this.x -= this.speed;
    if (this.x < (this.screenWidth - this.width) && this.moveHorizontal == 1)
      this.x += this.speed;

    //Accounts for the vertical movement, to the top and to the bottom,
    //making sure it will not cross the topmost and bottommost borders
    if (this.y > 40 && this.moveHorizontal == -1) this.y -= this.speed;
    if (this.y < (this.screenWidth - this.height - 10) &&
        this.moveHorizontal == 1) this.y += this.speed;
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

  void orientationChanged()
  {
    /*This method changes the object's steer angle according to
    * its horizontal and vertical directions*/

    this.radians = 0.0;//Initializes the steer angle

    //Verifies the movement directions, and changes the steer
    //angle accordingly
    if(this.moveHorizontal == 1 && this.moveVertical == -1)
      this.radians = this.angles2Radians['angle45'];
    else if(this.moveHorizontal == 1 && this.moveVertical == 0)
      this.radians = this.angles2Radians['angle90'];
    else if(this.moveHorizontal == 1 && this.moveVertical == 1)
      this.radians = this.angles2Radians['angle135'];
    else if(this.moveHorizontal == 0 && this.moveVertical == 1)
      this.radians = this.angles2Radians['angle180'];
    else if(this.moveHorizontal == -1 && this.moveVertical == 1)
      this.radians = this.angles2Radians['angle225'];
    else if(this.moveHorizontal == -1 && this.moveVertical == 0)
      this.radians = this.angles2Radians['angle270'];
    else if(this.moveHorizontal == -1 && this.moveVertical == -1)
      this.radians = this.angles2Radians['angle315'];
  }

  bool collidesWith(GameObject someObject)
  {
    /*Verifies if some sprite has collided with the player*/

    //Can't collide with something invisible
    if(!this.isVisible || !someObject.isVisible) return false;

    //Defines the borders of the player
    var leftPlayer = this.x;
    var rightPlayer = this.x + this.width;
    var topPlayer = this.y;
    var bottomPlayer = this.y + this.height;

    //Defines the borders of the object
    var leftObj = someObject.x;
    var rightObj = someObject.x + someObject.width;
    var topObj = someObject.y;
    var bottomObj = someObject.y + someObject.height;

    //Verifies the if any condition that makes collision impossible
    // has been met
    if(bottomPlayer < topObj) return false;
    if(bottomObj < topPlayer) return false;
    if(rightPlayer < leftObj) return false;
    if(rightObj < leftPlayer) return false;

    return true;//If it came to this point, there was, indeed, a collision
  }

  void sucksEnergy()
  {}

  void losesEnergy()
  {}
}
