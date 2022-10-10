// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import, implementation_imports, avoid_print, avoid_unnecessary_containers
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../model/ListOfSongs.dart';
import '../model/Song.dart';

class MusicPlayer extends StatefulWidget {
  const MusicPlayer({Key? key}) : super(key: key);

  @override
  State<MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<MusicPlayer> {
  var i = 0;
  final player = AudioPlayer();
  bool isPlaying = false;
  double timePosition = 0;
  Duration? timeDuration = Duration.zero;
  IconData iconPlayer = Icons.play_arrow;
  Song songPlaying = songs.elementAt(0);

  Future initPlayer() async {
    player.setReleaseMode(ReleaseMode.loop);
    await player.setSource(songPlaying.audio);
    timeDuration = await player.getDuration();
  }

  //init the player
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(),
            height: 300.0,
            width: 300.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: songPlaying.image,
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 28, sigmaY: 28),
              child: Container(
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //setting the music cover
              ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image(
                  image: songPlaying.image,
                  width: 250.0,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                songPlaying.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white, fontSize: 36, letterSpacing: 6),
              ),
              //Setting the seekbar
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "0${(timePosition / 60).floor()}: ${(timePosition % 60).floor()}",
                    style: TextStyle(color: Colors.white),
                  ),
                  Container(
                    width: 210.0,
                    child: Slider.adaptive(
                      onChanged: (v) {
                        setState(() {
                          timePosition = v;
                        });
                      },
                      onChangeEnd: (new_value) async {
                        setState(() {
                          timePosition = new_value;
                          print(new_value);
                        });
                        await player.seek(Duration(seconds: new_value.toInt()));
                      },
                      min: 0.0,
                      value: timePosition,
                      max: 214.0,
                      activeColor: Colors.white,
                    ),
                  ),
                  Text(
                    "0${timeDuration!.inMinutes} : ${timeDuration!.inSeconds % 60}",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              //setting the player controller
              SizedBox(
                height: 60.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        if (i >= 1) {
                          i = i - 1;
                          songPlaying = songs.elementAt(i);
                        } else {
                          i = songs.length;
                          songPlaying = songs.elementAt(i);
                        }
                        initPlayer();
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_rewind_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.pink),
                    ),
                    width: 60.0,
                    height: 60.0,
                    child: InkWell(
                      onTap: () async {
                        if (isPlaying) {
                          setState(() {
                            iconPlayer = Icons.play_arrow;
                          });
                          await player.pause();
                          isPlaying = !isPlaying;
                        } else {
                          setState(() {
                            iconPlayer = Icons.pause;
                          });
                          await player.resume();

                          player.onPositionChanged.listen((position) {
                            setState(() {
                              timePosition = position.inSeconds.toDouble();
                            });
                          });
                          isPlaying = !isPlaying;
                        }
                      },
                      child: Center(
                          child: (Icon(iconPlayer, color: Colors.white))),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60.0),
                      color: Colors.black87,
                      border: Border.all(color: Colors.white38),
                    ),
                    width: 50.0,
                    height: 50.0,
                    child: InkWell(
                      onTap: () async {
                        if (i < songs.length && i >= 0) {
                          i = i + 1;
                          songPlaying = songs.elementAt(i);
                        } else {
                          i = 0;
                          songPlaying = songs.elementAt(i);
                        }
                        initPlayer();
                      },
                      child: Center(
                        child: Icon(
                          Icons.fast_forward_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
