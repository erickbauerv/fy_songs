// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, implementation_imports, avoid_print
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({super.key});

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  // Variables
  bool isPlaying = false;
  double value = 0;

  // Create an instance of the music player
  final player = AudioPlayer();

  // Setting the duration
  Duration? duration = Duration(seconds: 0);

  // Create a function to initiate the music into the player
  void initPlayer() async {
    await player.setSource(AssetSource("The Outside.mp3"));

    duration = await player.getDuration();
  }

  @override
  void initState() {
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // First add some decoration
          Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/scaled_and_icy.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              // Add blur
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black54,
              ),
            ),
          ),

          // Layout of the app
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.asset(
                  "assets/scaled_and_icy.jpg",
                  width: 250.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "The Outside",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  letterSpacing: 6,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Will be modified while the music streams
                  Text(
                    "${(value / 60).floor()} : ${(value % 60).floor()}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Slider.adaptive(
                    onChanged: (v) {
                      setState(() {
                        value = v;
                      });
                    },
                    min: 0.0,
                    max: duration!.inSeconds.toDouble(),
                    value: value,
                    onChangeEnd: (newValue) async {
                      setState(() {
                        value = newValue;
                        print(newValue);
                      });
                      player.pause();
                      await player.seek(Duration(seconds: newValue.toInt()));
                      await player.resume();
                    },
                    activeColor: Colors.white,
                  ),
                  // Show the total duration of the song
                  Text(
                    "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black54,
                  border: Border.all(color: Colors.pink),
                ),
                child: InkWell(
                  onTap: () async {
                    if (isPlaying) {
                      await player.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      await player.resume();
                      setState(() {
                        isPlaying = true;
                      });
                      // Track the value
                      player.onPositionChanged.listen((position) {
                        setState(() {
                          value = position.inSeconds.toDouble();
                        });
                      });
                    }
                  },
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
