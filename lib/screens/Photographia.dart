import 'dart:async';
import 'dart:io';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Photographia {
  File imageFile;
  bool imageUploadStatus = false;
  int idIncremental = 0;

  void setImageUploadedStatus(bool status) {
    imageUploadStatus = status;
  }

  bool getImageUploadStatus() {
    return imageUploadStatus;
  }

  Future<File> getImageFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    return image;
  }

  Future<File> getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    return image;
  }

//  Future<Null> uploadImage(String path) async
//  {
//    //send and recieve the image url..
//      final ByteData bytes = await rootBundle.load(path);
//      final Directory directoryTmp = Directory.systemTemp;
//      final String fileName = '${Random().nextInt(100000)}.jpg';
//      final File file = File('${directoryTmp.path}/$fileName');
//      file.writeAsBytes(bytes.buffer.asInt8List(),mode: FileMode.write);
//
//
//
//      //upload code lines...
//      final StorageReference firebaseStorageRef =
//      FirebaseStorage.instance.ref().child(fileName);
//      final StorageUploadTask task =
//      firebaseStorageRef.putFile(file);
//  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: imageFile.path,
    );
    imageFile = cropped ?? imageFile;
  }

  void _clear() {
    imageFile = null;
  }
}
