import 'package:flutter_hero/GameObject.dart';

class Player extends GameObject
{
  Player(double inScreenWidth, double inScreenHeight, String inBaseFileName, int inWidth, int inHeight, int inNumFrames, int inFrameSkip, Function inAnimationCallback) : super(inScreenWidth, inScreenHeight, inBaseFileName, inWidth, inHeight, inNumFrames, inFrameSkip, inAnimationCallback);

  @override
  void move()
  {
    // TODO: implement move
  }
}



