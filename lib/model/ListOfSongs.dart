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
      name: "Enemy",
      image: const AssetImage("assets/enemy.jpg"),
      audio: AssetSource("Enemy.mp3")),
  Song(
      name: "Gimme Love",
      image: const AssetImage("assets/gimme_love.jpg"),
      audio: AssetSource("LimboDoMeninoSemOlhos.mp3")),
  Song(
      name: "Menino sem Olhos",
      image: const AssetImage("assets/limbo_do_menino_sem_olhos.jpg"),
      audio: AssetSource("LimboDoMeninoSemOlhos.mp3")),
];
