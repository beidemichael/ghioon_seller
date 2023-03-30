import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghioon_seller/Providers/language_provider.dart';
import 'package:ghioon_seller/Screens/HomeScreenWidets/ProductScreens/Product/AddProductsWidgets/addProductDetailLogic/addProductDetailLogic.dart';
import 'package:ghioon_seller/Service/Product/AddProductDatabase.dart';
import 'package:ghioon_seller/Shared/language.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import '../../../../../../Models/models.dart';
import '../../../../../../Providers/EditRangeProvider.dart';
import '../../../../../../Providers/RangeProvider.dart';
import '../../../../../../Service/uploadPhoto.dart';
import '../../../../../../Shared/customColors.dart';

class EditVideoContainer extends StatefulWidget {
  var product;
  int index;
  EditVideoContainer({super.key, required this.product, required this.index});

  @override
  State<EditVideoContainer> createState() => _EditVideoContainerState();
}

class _EditVideoContainerState extends State<EditVideoContainer> {
  final ImagePicker _picker = ImagePicker();
  File? _video;
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool videoSquare = true;
  bool videoLessThanSix = true;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network(widget.product.video == ''
        ? 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4'
        : widget.product.video)
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
    final appState = Provider.of<EditRangeData>(context, listen: false);
    appState.videoSubmited = true;
    if (_controller.value.size.height != _controller.value.size.width) {
      appState.videoSquare = false;
    }
    if (_controller.value.duration.inSeconds > 5) {
      appState.videoLessThanSix = false;
    }

    if (_controller.value.duration.inSeconds < 6 &&
        _controller.value.size.height == _controller.value.size.width) {
      var uploadedVideo = await uploadVideo(
          _video, FirebaseAuth.instance.currentUser!.uid, 'Products');
      final videoString = uploadedVideo.toString();
      AddProductDatabase().uploadVideo(widget.product.documentId, videoString);
    }
  }

  @override
  Widget build(BuildContext context) {
    var languageprov = Provider.of<LanguageProvider>(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final appState = Provider.of<EditRangeData>(context);
    final products = Provider.of<List<Product>>(context);
    // var _images = context.watch<EditRangeData>().Images;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          products[widget.index].video != ''
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
                            Language()
                                    .vide_duration[languageprov.LanguageIndex] +
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
                            child: Text(
                              Language()
                                  .square_video[languageprov.LanguageIndex],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.red),
                            ),
                          ),
                          Visibility(
                            visible: !appState.videoLessThanSix,
                            child: Text(
                              Language()
                                  .sixsec_video[languageprov.LanguageIndex],
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
