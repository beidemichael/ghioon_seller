import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:video_compress/video_compress.dart';

Future<String> uploadImage(File? image, String Uid, String folder) async {
  String fileName = basename(image!.path);
  // String owner = userID.toString();
  // print("===============");
  // print(fileName);
  Reference storageRef =
      FirebaseStorage.instance.ref().child('$folder/$Uid/$fileName');
  await storageRef.putFile(image);
  return await storageRef.getDownloadURL();
}

Future<String> uploadVideo(File? video, String Uid, String folder) async {
  await VideoCompress.setLogLevel(0);
  final info = await VideoCompress.compressVideo(
    video!.path,
    quality: VideoQuality.Res960x540Quality,
    deleteOrigin: false,
    includeAudio: false,
  );
  String? fileName = basename(info!.path.toString());
  // String owner = userID.toString();
  // print("===============");
  // print(fileName);
  Reference storageRef =
      FirebaseStorage.instance.ref().child('$folder/$Uid/$fileName');
  await storageRef.putFile(video);
  return await storageRef.getDownloadURL();
}
