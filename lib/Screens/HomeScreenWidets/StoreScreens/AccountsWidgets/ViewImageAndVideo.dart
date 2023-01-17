// ignore_for_file: non_constant_identifier_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../Models/models.dart';
import '../../../../../../Shared/constants.dart';
import '../../../../../../Shared/customColors.dart';
import '../../../../Service/Profile/ProfileDatabase.dart';
import '../../../../Service/uploadPhoto.dart';
import '../../../components/alert.dart';

class ViewImageAndVideo extends StatefulWidget {
  UserInformation user;
  ViewImageAndVideo({super.key, required this.user});

  @override
  State<ViewImageAndVideo> createState() => _ViewImageAndVideoState();
}

class _ViewImageAndVideoState extends State<ViewImageAndVideo> {
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  int ImageIndex = 0;
  late VideoPlayerController _controller;
  bool play = false;
  bool clear = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.user.profileVideo == ''
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        : widget.user.profileVideo)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future pickImage(
        ImageSource source, int index, UserInformation user) async {
      final image = await _picker.pickImage(
        source: source,
      );

      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        loading = true;
      });
      var uploadedPhoto = await uploadImage(
          imageTemporary, FirebaseAuth.instance.currentUser!.uid, 'Profile');
      ProfileDatabase().addImage(uploadedPhoto, user.documentId);
      setState(() {
        loading = false;
      });
    }

    if (play == false) {
      _controller.pause();
    }
    return widget.user.profileImages.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: CustomColors().white,
                  border: Border.all(
                      width: 1,
                      color: const Color.fromARGB(255, 199, 199, 199)),
                ),
                child: loading == true
                    ? SpinKitCircle(
                        color: Colors.grey,
                        size: 40.0,
                      )
                    : Icon(
                        size: 50,
                        FontAwesomeIcons.image,
                        color: Color.fromARGB(255, 204, 204, 204),
                      ),
              ),
            ),
          )
        : Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      clear = !clear;
                    });
                  },
                  child: Center(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(200.0),
                      ),
                      child: Container(
                        //image
                        width: ScreenSize().ScreenWidth(context) * 0.5,
                        height: ScreenSize().ScreenWidth(context) * 0.5,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10.0),
                              bottomRight: Radius.circular(10.0)),
                          color: Colors.grey[200],
                        ),
                        child: widget.user.profileImages[ImageIndex] != ''
                            ? ClipRRect(
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      widget.user.profileImages[ImageIndex],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey[300]!),
                                          value: downloadProgress.progress),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                ),
                              )
                            : Center(
                                child: Icon(
                                  Icons.newspaper_rounded,
                                  size: 10,
                                  color: Colors.grey[400],
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: play,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      clear = !clear;
                    });
                  },
                  child: Center(
                    child: widget.user.profileVideo != ''
                        ? _controller.value.isInitialized
                            ? ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(200.0),
                                ),
                                child: Container(
                                  color: Colors.white,
                                  width:
                                      ScreenSize().ScreenWidth(context) * 0.5,
                                  height:
                                      ScreenSize().ScreenWidth(context) * 0.5,
                                  child: AspectRatio(
                                    aspectRatio: _controller.value.aspectRatio,
                                    child: VideoPlayer(_controller),
                                  ),
                                ),
                              )
                            : Container()
                        : Container(),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                  Container(
                    color: Colors.black.withOpacity(0.4),
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    alignment: Alignment.center,
                    child: Center(
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics()),
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.user.profileImages.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                ImageIndex = index;
                                play = false;
                              });
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: index == 0,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Stack(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  if (_controller
                                                      .value.isPlaying) {
                                                    _controller.pause();
                                                    play = false;
                                                  } else {
                                                    _controller.play();
                                                    _controller
                                                        .setLooping(true);
                                                    play = true;
                                                  }
                                                });
                                              },
                                              child: Center(
                                                child:
                                                    widget.user.profileVideo !=
                                                            ''
                                                        ? _controller.value
                                                                .isInitialized
                                                            ? Stack(
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child:
                                                                        Container(
                                                                      color: Colors
                                                                          .red,
                                                                      width: 90,
                                                                      height:
                                                                          90,
                                                                      child:
                                                                          AspectRatio(
                                                                        aspectRatio: _controller
                                                                            .value
                                                                            .aspectRatio,
                                                                        child: VideoPlayer(
                                                                            _controller),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0,
                                                                    child:
                                                                        ClipRRect(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.2),
                                                                        width:
                                                                            90,
                                                                        height:
                                                                            90,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    left: 0,
                                                                    right: 0,
                                                                    top: 0,
                                                                    bottom: 0,
                                                                    child: Icon(
                                                                      size: 40,
                                                                      play == false
                                                                          ? FontAwesomeIcons
                                                                              .play
                                                                          : FontAwesomeIcons
                                                                              .pause,
                                                                      color: CustomColors()
                                                                          .white,
                                                                    ),
                                                                  )
                                                                ],
                                                              )
                                                            : ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child:
                                                                    Container(
                                                                  color: Colors
                                                                      .white
                                                                      .withOpacity(
                                                                          0.5),
                                                                  width: 90,
                                                                  height: 90,
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        SpinKitCircle(
                                                                      color: Colors
                                                                          .white,
                                                                      size:
                                                                          25.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                        : Container(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(8.0)),
                                      child: Container(
                                        //image
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                        ),
                                        child: widget.user
                                                    .profileImages[index] !=
                                                ''
                                            ? ClipRRect(
                                                child: CachedNetworkImage(
                                                  fit: BoxFit.cover,
                                                  imageUrl: widget.user
                                                      .profileImages[index],
                                                  progressIndicatorBuilder:
                                                      (context, url,
                                                              downloadProgress) =>
                                                          Center(
                                                    child: Container(
                                                      height: 20,
                                                      width: 20,
                                                      child: CircularProgressIndicator(
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                      Color>(
                                                                  Colors.grey[
                                                                      300]!),
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                                    ),
                                                  ),
                                                  errorWidget:
                                                      (context, url, error) =>
                                                          Icon(Icons.error),
                                                ),
                                              )
                                            : Center(
                                                child: Icon(
                                                  Icons.newspaper_rounded,
                                                  size: 10,
                                                  color: Colors.grey[400],
                                                ),
                                              ),
                                      ),
                                    ),

                                    // floatingActionButton: FloatingActionButton(
                                    //   onPressed: () {
                                    //     setState(() {
                                    //       _controller.value.isPlaying
                                    //           ? _controller.pause()
                                    //           : _controller.play();
                                    //     });
                                    //   },
                                    //   child: Icon(
                                    //     _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
