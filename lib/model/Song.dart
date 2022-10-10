import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class Song {
  String name;
  AssetImage image;
  AssetSource audio;

  Song({
    required this.name,
    required this.image,
    required this.audio,
  });
}
