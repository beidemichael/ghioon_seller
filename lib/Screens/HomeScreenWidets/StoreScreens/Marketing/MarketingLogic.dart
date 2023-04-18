import 'package:flutter/material.dart';
import 'package:ghioon_seller/Service/Compression/image_compression.dart';

import '../../../../Service/Marketing/MarketingDatabase.dart';
import '../../../../Service/uploadPhoto.dart';

class MarketingLogic {
  IfImage(bool input) {
    return input;
  }

  ImageAspectRatio(input) async {
    var decodedImage = await decodeImageFromList(input.readAsBytesSync());
    print('ImageAspectRation: ' +
        (decodedImage.height / decodedImage.width).toString());
    if ((decodedImage.height / decodedImage.width) > 1.5 &&
        (decodedImage.height / decodedImage.width) < 1.8) {
      print('Returned: 16:9');
      return 16;
    } else if ((decodedImage.height / decodedImage.width) > 0.8 &&
        (decodedImage.height / decodedImage.width) < 1.2) {
      print('Returned: 1:1');
      return 1;
    } else {
      print('Returned: null');
      return 0;
    }
  }

  UploadImage(input, user, screenRealestate) async {
    var imageString =
        await uploadImage(input, user!.uid.toString(), 'Marketing');
    await uploadToDatabase(
        await imageString, '', true, user, screenRealestate, user);
  }

  VideoAspectRatio(input) async {
    print('VideoAspect ratio: ' + (1/input.value.aspectRatio).toString());
    return (1/input.value.aspectRatio);
  }

  uploadVideoLogic(input, user, screenRealestate) async {
    var videoString =
        await uploadVideo(input, user!.uid.toString(), 'Marketing');
    await uploadToDatabase(
        '', await videoString, false, user, screenRealestate, user);
  }

  uploadToDatabase(imageString, videoString, imagType, sellerUid,
      screenRealestate, user) async {
    return await AddMarketingdatabase().addMarketing(imageString, videoString,
        imagType, user!.uid, screenRealestate.toString());
  }
}
