import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:developer';

class PlayPage extends StatefulWidget {
  final String currentvideoID;
  final String videoTitle;

  PlayPage({Key key, this.currentvideoID, this.videoTitle}) : super(key: key);
  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;
  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.currentvideoID,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              widget.videoTitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller.load(widget.currentvideoID);
          _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        key: _scaffoldKey,
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _space,
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(Icons.search_rounded), onPressed: () {}),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text("Quest Content"),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0xFF35CDA4)),
                            backgroundColor: MaterialStateProperty.all(
                                Colors.white.withOpacity(0.5)),
                            textStyle: MaterialStateProperty.all(TextStyle(
                              color: Colors.black,
                            )),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.search_rounded),
                          label: Text("Q&A"),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0xFF35CDA4)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: Icon(Icons.search_rounded),
                          label: Text("Notes"),
                          style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Color(0xFF35CDA4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
  // Widget _text(String title, String value) {
  //   return RichText(
  //     text: TextSpan(
  //       text: '${widget.videoTitle} : ',
  //       style: const TextStyle(
  //         color: Colors.blueAccent,
  //         fontWeight: FontWeight.bold,
  //       ),
  //       children: [
  //         TextSpan(
  //           text: value ?? '',
  //           style: const TextStyle(
  //             color: Colors.blueAccent,
  //             fontWeight: FontWeight.w300,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
  // Color _getStateColor(PlayerState state) {
  //   switch (state) {
  //     case PlayerState.unknown:
  //       return Colors.grey[700];
  //     case PlayerState.unStarted:
  //       return Colors.pink;
  //     case PlayerState.ended:
  //       return Colors.red;
  //     case PlayerState.playing:
  //       return Colors.blueAccent;
  //     case PlayerState.paused:
  //       return Colors.orange;
  //     case PlayerState.buffering:
  //       return Colors.yellow;
  //     case PlayerState.cued:
  //       return Colors.blue[900];
  //     default:
  //       return Colors.blue;
  //   }
  // }
  // Widget _loadCueButton(String action) {
  //   return Expanded(
  //     child: MaterialButton(
  //       color: Colors.blueAccent,
  //       onPressed: _isPlayerReady
  //           ? () {
  //               if (_idController.text.isNotEmpty) {
  //                 var id = YoutubePlayer.convertUrlToId(
  //                   _idController.text,
  //                 );
  //                 if (action == 'LOAD') _controller.load(id);
  //                 if (action == 'CUE') _controller.cue(id);
  //                 FocusScope.of(context).requestFocus(FocusNode());
  //               } else {
  //                 _showSnackBar('Source can\'t be empty!');
  //               }
  //             }
  //           : null,
  //       disabledColor: Colors.grey,
  //       disabledTextColor: Colors.black,
  //       child: Padding(
  //         padding: const EdgeInsets.symmetric(vertical: 14.0),
  //         child: Text(
  //           action,
  //           style: const TextStyle(
  //             fontSize: 18.0,
  //             color: Colors.white,
  //             fontWeight: FontWeight.w300,
  //           ),
  //           textAlign: TextAlign.center,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  void _showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }
}
