import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

Future<File> compressFile(File file) async {
  final filePath = file.absolute.path;

  // Create output file path
  // eg:- "Volume/VM/abcd_out.jpeg"
  final lastIndex = filePath.lastIndexOf(new RegExp(r'.jp'));
  final splitted = filePath.substring(0, (lastIndex));
  final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
  var result = await FlutterImageCompress.compressAndGetFile(
    file.absolute.path,
    outPath,
    quality: 70,
  );

  print(file.lengthSync());
  print(result!.lengthSync());

  return result;
}


Future<File> changeImage(dynamic imageFile, BuildContext context) async {
  // Request write permission if not granted
  final hasWritePermission = await _requestWritePermission(context);
  if (!hasWritePermission) {
    // throw Exception('User did not grant write permission.');
    _requestWritePermission( context);
  }

  // Read the image bytes from the file
  final bytes = await imageFile.readAsBytes();

  // Decode the image from bytes
  final rawImage = img.decodeImage(bytes);

  // Check if image decoding failed
  if (rawImage == null) {
    throw Exception('Failed to decode image.');
  }

  // Crop the image to a square
  final size =
      rawImage.width > rawImage.height ? rawImage.height : rawImage.width;
  final croppedImage = img.copyCrop(rawImage, (rawImage.width - size) ~/ 2,
      (rawImage.height - size) ~/ 2, size, size);

  // Check if cropping failed
  if (croppedImage == null) {
    throw Exception('Failed to crop image.');
  }

  // Resize the image to 500x500 pixels
  final resizedImage = img.copyResize(croppedImage, width: 500, height: 500);

  // Check if resizing failed
  if (resizedImage == null) {
    throw Exception('Failed to resize image.');
  }

  // Encode the resized image to PNG format
  final resizedBytes = img.encodePng(resizedImage);

  // Get the app's cache directory
  final cacheDir = await getTemporaryDirectory();

  // Create a new file to write the resized image to
  final resizedFile = File(
      '${cacheDir.path}/${DateTime.now().millisecondsSinceEpoch}_resized.png');

  // Write the resized image to the new file
  await resizedFile.writeAsBytes(resizedBytes);

  return resizedFile;
}

Future<bool> _requestWritePermission(BuildContext context) async {
  final permission =
      Platform.isIOS ? Permission.storage : Permission.manageExternalStorage;
  final status = await permission.request();
  if (status == PermissionStatus.granted) {
    return true;
  } else if (status == PermissionStatus.permanentlyDenied) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Permission Required'),
          content: Text('Please grant storage permission to use this feature.'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => openAppSettings(),
              child: Text('Settings'),
            ),
          ],
        );
      },
    );
  }
  return false;
}
