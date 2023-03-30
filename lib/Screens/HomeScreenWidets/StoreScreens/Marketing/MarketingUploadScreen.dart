import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/StoreScreens/Marketing/MarketingLogic.dart';
import 'package:ghioon_seller/Screens/components/BlueButton.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:ghioon_seller/Shared/loading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../Providers/language_provider.dart';
import '../../../../Service/uploadPhoto.dart';
import '../../../../Shared/customColors.dart';

class MarketingUploadScreen extends StatefulWidget {
  int screenRealestate;
  bool imagType;
  MarketingUploadScreen(
      {super.key, required this.imagType, required this.screenRealestate});

  @override
  State<MarketingUploadScreen> createState() => _MarketingUploadScreenState();
}

class _MarketingUploadScreenState extends State<MarketingUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  bool loading = false;
  File? _video;
  var videoDevice;
  File? photoDevice;
  String imageString = '';
  String videoString = '';
  bool videoSubmited = false;
  bool videoSquare = false;
  bool video16X9 = false;
  bool videoLessThanSix = false;
  bool imageSubmited = false;
  bool imageSquare = false;
  String message = '';

  late VideoPlayerController _controller;
  Future pickImage(ImageSource source) async {
    // final file = await ImagePicker().pickVideo(source: ImageSource.gallery);
    final image = await _picker.pickImage(
      source: source,
    );

    if (image == null) return;

    final imageTemporary = File(image.path);
    setState(() {
      photoDevice = imageTemporary;
      imageSubmited = true;
    });
  }

  pickVideo() async {
    // final appState = Provider.of<RangeData>(context, listen: false);
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
      videoDevice = _video;
      videoSubmited = true;
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {
        checkVideoParameter();
      });
    });
    //  checkParameter();
  }

  checkVideoParameter() {
    videoSubmited = true;

    if (_controller.value.size.height != _controller.value.size.width) {
      videoSquare = false;
    } else {
      videoSquare = true;
    }
    if (_controller.value.duration.inSeconds > 5) {
      videoLessThanSix = false;
    } else {
      videoLessThanSix = true;
    }
    // if(_controller.value.aspectRatio)
    print(
        'Aspect Ration of video: ' + _controller.value.aspectRatio.toString());
  }

  checkimageParameter() {
    imageSubmited = true;

    if (_controller.value.size.height != _controller.value.size.width) {
      videoSquare = false;
    } else {
      videoSquare = true;
    }
    if (_controller.value.duration.inSeconds > 5) {
      videoLessThanSix = false;
    } else {
      videoLessThanSix = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(69.0),
        child: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisSize: MainAxisSize.min,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Row(
                  children: [
                    Text(Language().upload[languageprov.LanguageIndex],
                        style: TextStyle(
                            fontSize: 30.0,
                            color: CustomColors().white,
                            fontWeight: FontWeight.w700)),
                    Text(
                        widget.imagType
                            ? Language().image[languageprov.LanguageIndex]
                            : Language().video[languageprov.LanguageIndex],
                        style: TextStyle(
                            fontSize: 30.0,
                            color: CustomColors().white,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ],
            ),
            // excludeHeaderSemantics: true,
            backgroundColor: CustomColors().blue,
            // automaticallyImplyLeading: false,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            iconTheme: IconThemeData(color: CustomColors().white)),
      ),
      body: loading
          ? Loading()
          : Stack(
              children: [
                Positioned(
                  top: -7,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height - 100,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              // border: Border.all(width: 1, color: CustomColors().blue),
                              color: CustomColors().white,
                              borderRadius: BorderRadius.circular(15.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 0.05,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50.0),
                                  child: Text(
                                      widget.screenRealestate > 60
                                          ? '16X9 ASPECT RATIO'
                                          : '1X1 ASPECT RATIO',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 25,
                                          color: CustomColors().grey,
                                          fontWeight: FontWeight.w400)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: GestureDetector(
                              onTap: () {
                                if (widget.imagType) {
                                  pickImage(ImageSource.gallery);
                                } else {
                                  pickVideo();
                                }
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: AspectRatio(
                                    aspectRatio: widget.screenRealestate > 60
                                        ? 9 / 16
                                        : 1 / 1,
                                    child: Container(
                                      // color: Colors.green,
                                      child: widget.imagType
                                          ? photoDevice != null
                                              ? Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: CustomColors()
                                                        .superLightBlue,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: CustomColors()
                                                            .blue),
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    child: Image.file(
                                                      photoDevice!,
                                                      fit: BoxFit.fitWidth,
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: CustomColors()
                                                        .superLightBlue,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: CustomColors()
                                                            .blue),
                                                  ),
                                                  child: Icon(
                                                    size: 50,
                                                    FontAwesomeIcons.image,
                                                    color: CustomColors().blue,
                                                  ),
                                                )
                                          : _video != null
                                              ? _controller.value.isInitialized
                                                  ? Column(
                                                      children: [
                                                        Container(
                                                          // color: Colors.red,
                                                          width: widget
                                                                      .screenRealestate <
                                                                  60
                                                              ? MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5
                                                              : MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5,
                                                          // height:
                                                          //     MediaQuery.of(context)
                                                          //             .size
                                                          //             .width *(0.5),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            child: AspectRatio(
                                                              aspectRatio:
                                                                  widget.screenRealestate >
                                                                          60
                                                                      ? 9 / 16
                                                                      : 1 / 1,
                                                              // aspectRatio:
                                                              //     _controller
                                                              //         .value
                                                              //         .aspectRatio,
                                                              child: VideoPlayer(
                                                                  _controller),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          'Video duration: ' +
                                                              _controller
                                                                  .value
                                                                  .duration
                                                                  .inSeconds
                                                                  .toString() +
                                                              ' Secs',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  CustomColors()
                                                                      .blue),
                                                        ),
                                                        // Visibility(
                                                        //   visible: !videoSquare,
                                                        //   child: const Text(
                                                        //     "Please submit a square video",
                                                        //     textAlign:
                                                        //         TextAlign.center,
                                                        //     style: TextStyle(
                                                        //         fontSize: 17,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: Colors.red),
                                                        //   ),
                                                        // ),
                                                        // Visibility(
                                                        //   visible: !videoLessThanSix,
                                                        //   child: const Text(
                                                        //     "Please submit a video less than 6 seconds",
                                                        //     textAlign:
                                                        //         TextAlign.center,
                                                        //     style: TextStyle(
                                                        //         fontSize: 17,
                                                        //         fontWeight:
                                                        //             FontWeight.w300,
                                                        //         color: Colors.red),
                                                        //   ),
                                                        // ),
                                                      ],
                                                    )
                                                  : Container()
                                              : Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: CustomColors()
                                                        .superLightBlue,
                                                    border: Border.all(
                                                        width: 1,
                                                        color: CustomColors()
                                                            .blue),
                                                  ),
                                                  child: Icon(
                                                    size: 50,
                                                    FontAwesomeIcons.play,
                                                    color: CustomColors().blue,
                                                  ),
                                                ),
                                    ),
                                  )),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: CustomColors().red),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Center(
                          child: GestureDetector(
                              onTap: () async {
                                final user = FirebaseAuth.instance.currentUser;

                                if (MarketingLogic().IfImage(widget.imagType)) {
                                  //If it's image
                                  if (imageSubmited) {
                                    //If image's submitted

                                    if (widget.screenRealestate > 60) {
                                      if (await MarketingLogic()
                                              .ImageAspectRatio(photoDevice) ==
                                          16) {
                                        //if Image 16:9
                                        setState(() {
                                          loading = true;
                                          message = '';
                                        });
                                        MarketingLogic().UploadImage(
                                            photoDevice,
                                            user,
                                            widget.screenRealestate);

                                        Navigator.of(context).pop();
                                      } else {
                                        //Image not 16:9
                                        setState(() {
                                          message = Language().imagenot169[
                                              languageprov.LanguageIndex];
                                        });
                                      }
                                    } else {
                                      if ((await MarketingLogic()
                                              .ImageAspectRatio(photoDevice)) ==
                                          1) {
                                        //if Image is 1:1
                                        setState(() {
                                          loading = true;
                                          message = '';
                                        });
                                        MarketingLogic().UploadImage(
                                            photoDevice,
                                            user,
                                            widget.screenRealestate);
                                        Navigator.of(context).pop();
                                      } else {
                                        //Image not 1:1
                                        setState(() {
                                          message = Language().imagenot11[
                                              languageprov.LanguageIndex];
                                        });
                                      }
                                    }
                                  } else {
                                    //Image is not submitted
                                    setState(() {
                                      message = Language()
                                          .no_image[languageprov.LanguageIndex];
                                    });
                                  }
                                } else {
                                  //If it's Video

                                  if (videoSubmited) {
                                    //If Video's submitted

                                    if (widget.screenRealestate > 60) {
                                      if ((await MarketingLogic()
                                              .VideoAspectRatio(_controller)) ==
                                          (16 / 9)) {
                                        //if Video 16:9
                                        setState(() {
                                          loading = true;
                                          message = '';
                                        });
                                        MarketingLogic().uploadVideoLogic(
                                            videoDevice,
                                            user,
                                            widget.screenRealestate);

                                        Navigator.of(context).pop();
                                      } else {
                                        //video not 16:9
                                        setState(() {
                                          message = Language().videonot169[
                                              languageprov.LanguageIndex];
                                        });
                                      }
                                    } else {
                                      if ((await MarketingLogic()
                                              .VideoAspectRatio(_controller)) ==
                                          (1)) {
                                        //if Video is 1:1
                                        setState(() {
                                          loading = true;
                                          message = '';
                                        });
                                        MarketingLogic().uploadVideoLogic(
                                            videoDevice,
                                            user,
                                            widget.screenRealestate);

                                        Navigator.of(context).pop();
                                      } else {
                                        //Image not 1:1
                                        setState(() {
                                          message = Language().videonot11[
                                              languageprov.LanguageIndex];
                                        });
                                      }
                                    }
                                  } else {
                                    //Image is not submitted
                                    setState(() {
                                      message = Language()
                                          .no_video[languageprov.LanguageIndex];
                                    });
                                  }
                                }

                                setState(() {
                                  loading = false;
                                });
                              },
                              child: BlueButton(
                                  text: Language()
                                      .submit[languageprov.LanguageIndex])),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
