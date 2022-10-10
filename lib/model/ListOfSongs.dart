import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

import 'Song.dart';

List<Song> songs = [
  Song(
      name: "The Outside",
      image: const AssetImage("assets/scaled_and_icy.jpg"),
      audio: AssetSource("TheOutside.mp3")),
  Song(
      name: "Sick of Being Honest",
      image: const AssetImage("assets/sick_of_being_honest.jpg"),
      audio: AssetSource("SickOfBeingHonest.mp3")),
  Song(
      name: "The Outside3",
      image: const AssetImage("assets/scaled_and_icy.jpg"),
      audio: AssetSource("TheOutside.mp3")),
];
