import 'package:flutter/material.dart';

 class GameObject
{

  //**********************Attributes**********************/

  //screen dimension
  double screenWidth = 0.0;
  double screenHeight = 0.0;

  String baseFileName = '';//object`s name

  //animated object`s dimensions
  int width = 0;
  int height = 0;

  //position attributes
  double x = 0.0;
  double y = 0.0;

  //animation related attributes
  int numFrames = 0;
  int frameSkip = 0;
  int currentFrame = 0;
  int frameCount = 0;
  List frames = [];
  Function animationCallback;
  bool isVisible = true;

  //**********************Methods**********************/

  GameObject(double inScreenWidth, double inScreenHeight,
      String inBaseFileName, int inWidth, int inHeight,
      int inNumFrames, int inFrameSkip, Function inAnimationCallback)
  {
    /*This is the constructor method*/

    //Initializes the object
    this..screenWidth = inScreenWidth
        ..screenHeight = inScreenHeight
        ..baseFileName = inBaseFileName
        ..width = inWidth
        ..height = inHeight
        ..numFrames = inNumFrames
        ..frameSkip = inFrameSkip
        ..animationCallback = inAnimationCallback;

    //Initializes the frames List attribute, by appending Image Widgets
    for(int i = 0; i < inNumFrames; i++)
    {
        frames.add(Image.asset('assets/images/$baseFileName-$i.png'));
    }
  }

  void animate()
  {
    /*This method keeps track of the objects frames*/

    //Increments the count and verifies if it has already overflown
    this.frameCount++;
    if(this.frameCount <= this.frameSkip) return;

    //Resets the frame count, and skips to the next frame
    //Also, checks if the last frame has been reached
    this..frameCount = 0
        ..currentFrame += 1;
    if(this.currentFrame < this.numFrames) return;

    //Resets the initial frame, and tries to run the callback
    this.currentFrame = 0;
    if(this.animationCallback != null){this.animationCallback();}

    return;
  }

  Widget draw()
  {
    /*This method draws the Widget*/

    //If the object is visible, returns a Positioned widget, which
    //encapsulates an Image widget
    return this.isVisible?
        Positioned(child: this.frames[this.currentFrame], left: this.x, top: this.y):
        Positioned(child: Container());
  }

}