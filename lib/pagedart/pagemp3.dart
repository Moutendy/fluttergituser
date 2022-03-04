import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class HomeMp3 extends StatefulWidget {
  const HomeMp3({Key? key}) : super(key: key);

  @override
  _HomeMp3State createState() => _HomeMp3State();
}

class _HomeMp3State extends State<HomeMp3> {
  bool playing = false;
  IconData playBtn = Icons.play_arrow;

  late AudioPlayer _player;
  late AudioCache cache;
  ScrollController scrollController = new ScrollController();
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.deepOrange,
        inactiveColor: Colors.red,
        value: position.inSeconds.toDouble() + 1.0,
        min: 0.0,
        max: musicLength.inSeconds.toDouble() + 10000.0,
        onChanged: (value) {
          seekToSec(value.toInt());
        });
  }

  void seekToSec(int sec) {
    Duration newPos = Duration(seconds: sec);
    _player.seek(newPos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);
    _player.onDurationChanged.listen((Duration d) {
      setState(() {
        musicLength = d;
      });
    });
    _player.onAudioPositionChanged.listen((Positioned) {
      setState(() {
        position = Positioned;
      });
    });
    cache.load("images/ekomy.mp3");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mp3'),
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.blueAccent,
              ]),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 48.0,
          ),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "music de mao",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        image: DecorationImage(
                          image: AssetImage("images/image.jpg"),
                        )),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                                iconSize: 45.0,
                                color: Colors.blueAccent,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_previous,
                                )),
                            IconButton(
                                iconSize: 45.0,
                                color: Colors.lightBlue,
                                onPressed: () {
                                  if (!playing) {
                                    _player.play("images/ekomy.mp3");

                                    setState(() {
                                      playBtn = Icons.pause;
                                      playing = true;
                                    });
                                  } else {
                                    _player.pause();
                                    setState(() {
                                      playBtn = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                                },
                                icon: Icon(
                                  playBtn,
                                )),
                            IconButton(
                                iconSize: 45.0,
                                color: Colors.blue,
                                onPressed: () {},
                                icon: Icon(
                                  Icons.skip_next,
                                )),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
