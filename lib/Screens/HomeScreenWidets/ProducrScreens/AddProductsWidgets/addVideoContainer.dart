import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../Providers/RangeProvider.dart';
import '../../../../Models/addProductmodels.dart';
import '../../../../Shared/customColors.dart';
import '../../../components/alert.dart';
import 'addProductDetailLogic/addProductDetailLogic.dart';

class AddVideoContainer extends StatefulWidget {
  const AddVideoContainer({
    super.key,
  });

  @override
  State<AddVideoContainer> createState() => _AddVideoContainerState();
}

class _AddVideoContainerState extends State<AddVideoContainer> {
  final ImagePicker _picker = ImagePicker();
  File? _video;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool videoSquare = true;
  bool videoLessThanSix = true;
  // @override
  // void initState() {
  //   super.initState();
  //   // Create and store the VideoPlayerController. The VideoPlayerController
  //   // offers several different constructors to play videos from assets, files,
  //   // or the internet.
  //   _controller = VideoPlayerController.network(
  //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
  //   );

  //   // Initialize the controller and store the Future for later use.
  //   _initializeVideoPlayerFuture = _controller.initialize();

  //   // Use the controller to loop the video.
  //   _controller.setLooping(true);
  // }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  pickVideo() async {
    final appState = Provider.of<RangeData>(context, listen: false);
    final video = await _picker.pickVideo(source: ImageSource.gallery);
    if (video == null) return;
    _video = File(video.path);
    _controller = VideoPlayerController.file(_video!)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });

    setState(() {
      appState.video = _video;
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        checkParameter();
      });
     
    });
    //  checkParameter();
  }

  checkParameter() {
    final appState = Provider.of<RangeData>(context, listen: false);
    appState.videoSubmited = true;
    if (_controller.value.size.height != _controller.value.size.width) {
      appState.videoSquare = false;
    }
    if (_controller.value.duration.inSeconds > 5) {
      appState.videoLessThanSix = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appState = Provider.of<RangeData>(context);
    var _images = context.watch<RangeData>().Images;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _video != null
              ? _controller.value.isInitialized
                  ? GestureDetector(
                      onTap: () {
                        if (_controller.value.isInitialized) {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                            _controller.setLooping(false);
                          }
                        }
                        pickVideo();
                        Future.delayed(const Duration(milliseconds: 500), () {
                          AddProductDetailLogic().checkVideo(
                              context, videoSquare, videoLessThanSix);
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            color: Colors.red,
                            width: width * .5,
                            height: width * .5,
                            child: AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                          Text(
                            'Video duration: ' +
                                _controller.value.duration.inSeconds
                                    .toString() +
                                ' Secs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: CustomColors().blue),
                          ),
                          Visibility(
                            visible: !appState.videoSquare,
                            child: const Text(
                              "Please submit a square video",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red),
                            ),
                          ),
                          Visibility(
                            visible: !appState.videoLessThanSix,
                            child: const Text(
                              "Please submit a video less than 6 seconds",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container()
              : GestureDetector(
                  onTap: () {
                    pickVideo();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      AddProductDetailLogic()
                          .checkVideo(context, videoSquare, videoLessThanSix);
                    });
                  },
                  child: Container(
                    height: width * .5,
                    width: width * .5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColors().superLightBlue,
                      border: Border.all(width: 1, color: CustomColors().blue),
                    ),
                    child: Icon(
                      size: 50,
                      FontAwesomeIcons.play,
                      color: CustomColors().blue,
                    ),
                  ),
                )
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text('Butterfly Video'),
    //   ),
    //   // Use a FutureBuilder to display a loading spinner while waiting for the
    //   // VideoPlayerController to finish initializing.
    //   body: FutureBuilder(
    //     future: _initializeVideoPlayerFuture,
    //     builder: (context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         // If the VideoPlayerController has finished initialization, use
    //         // the data it provides to limit the aspect ratio of the video.
    //         return AspectRatio(
    //           aspectRatio: _controller.value.aspectRatio,
    //           // Use the VideoPlayer widget to display the video.
    //           child: VideoPlayer(_controller),
    //         );
    //       } else {
    //         // If the VideoPlayerController is still initializing, show a
    //         // loading spinner.
    //         return const Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       }
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       // Wrap the play or pause in a call to `setState`. This ensures the
    //       // correct icon is shown.
    //       setState(() {
    //         // If the video is playing, pause it.
    //         if (_controller.value.isPlaying) {
    //           _controller.pause();
    //         } else {
    //           // If the video is paused, play it.
    //           _controller.play();
    //         }
    //       });
    //     },
    //     // Display the correct icon depending on the state of the player.
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
  }
}
