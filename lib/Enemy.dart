import 'package:flutter_hero/GameObject.dart';

class Enemy extends GameObject
{

  //**********************Attributes**********************/

  //Movement related attributes
  int speed = 0;
  int moveDirection = 0;

  //**********************Methods**********************/

  Enemy(double inScreenWidth, double inScreenHeight,
        String inBaseFileName, int inWidth, int inHeight,
        int inNumFrames, int inFrameSkip, Function inAnimationCallback,
        int inSpeed, int inMoveDirection):
        super(inScreenWidth, inScreenHeight, inBaseFileName,
          inWidth, inHeight, inNumFrames, inFrameSkip, inAnimationCallback)
  {
    /*This is the constructor method*/
    this..speed = inSpeed
        ..moveDirection = inMoveDirection;
  }

  @override
  void move()
  {
    /*This method changes the objects position according to the speed
    * and the direction*/

    //Verifies the movement direction
    if(this.moveDirection == 1)//to the right
    {

      //Moves the object to the right, and checks if it reached the right
      //border of the screen
      this.x += this.speed;
      if(this.x > this.screenWidth + this.width) this.x = -this.width.toDouble();

    }
    else//to the left
    {

      //Moves the object to the left, and checks if it reached the left
      //border of the screen
      this.x -= this.speed;
      if(this.x < -this.width) this.x = this.x = this.screenWidth + this.width.toDouble();
    }
  }
}