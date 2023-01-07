import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../Models/models.dart';
import '../../../../../Providers/RangeProvider.dart';
import '../../../../../Models/addProductmodels.dart';
import '../../../../../Service/Profile/ProfileDatabase.dart';
import '../../../../../Service/uploadPhoto.dart';
import '../../../../../Shared/customColors.dart';
import '../../../../components/alert.dart';

class AddProfileVideoContainer extends StatefulWidget {
  UserInformation user;
  AddProfileVideoContainer({required this.user});
  @override
  State<AddProfileVideoContainer> createState() =>
      _AddProfileVideoContainerState();
}

class _AddProfileVideoContainerState extends State<AddProfileVideoContainer> {
  final ImagePicker _picker = ImagePicker();
  File? _video;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool videoSquare = true;
  bool videoLessThanSix = true;
  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.user.profileVideo == ''
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        : widget.user.profileVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  pickVideo() async {
    // final appState = Provider.of<EditRangeData>(context, listen: false);
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

    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        checkParameter();
      });
    });
    //  checkParameter();
  }

  checkParameter() async {
    if (_controller.value.size.height != _controller.value.size.width) {
      setState(() {
        videoSquare = false;
      });
    } else {
      setState(() {
        videoSquare = true;
      });
    }
    if (_controller.value.duration.inSeconds > 5) {
      setState(() {
        videoLessThanSix = false;
      });
    } else {
      setState(() {
        videoLessThanSix = true;
      });
    }

    if (_controller.value.duration.inSeconds < 6 &&
        _controller.value.size.height == _controller.value.size.width) {
      var uploadedVideo = await uploadVideo(
          _video, FirebaseAuth.instance.currentUser!.uid, 'ProfileVideo');
      final videoString = uploadedVideo.toString();
      ProfileDatabase().uploadVideo(widget.user.documentId, videoString);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final appState = Provider.of<EditRangeData>(context);
    // final products = Provider.of<List<Product>>(context);
    // var _images = context.watch<EditRangeData>().Images;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.user.profileVideo != ''
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
                            visible: !videoSquare,
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
                            visible: !videoLessThanSix,
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
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        color: Colors.black.withOpacity(0.5),
                        width: width * .5,
                        height: width * .5,
                        child: const Center(
                          child: SpinKitCircle(
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    pickVideo();
                    Future.delayed(const Duration(milliseconds: 500), () {});
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
  }
}
