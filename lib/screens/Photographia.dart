import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:math';

class Photographia extends StatefulWidget {
  @override
  _PhotographiaState createState() => _PhotographiaState();
  bool imageUploadStatus = false;
  int _random = Random().nextInt(100000);
  int idIncremental = 0;
  int getRandom()
  {
    return _random;
  }

  void setRandom(int imageId){
    _random = imageId;
  }

  void setImageUploadedStatus(bool status)
  {
    imageUploadStatus = status;
  }
  bool getImageUploadStatus()
  {
    return imageUploadStatus;
  }
}

class _PhotographiaState extends State<Photographia> {
  File _imageFile;

  Future getImageFromGallery() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  Future getImageFromCam() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _imageFile = image;
    });
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
  @override
  Widget build(BuildContext context) {
    int imageId;
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Upload your photo')),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.lightBlue,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: () {
                getImageFromCam();
              },
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: () {
                getImageFromGallery();
              },
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
           // width: MediaQuery.of(context).size.width,
            child: Column(
              children: <Widget>[
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _imageFile == null
                        ? Image.asset('assets/images/alt_img.png',width: 400.0,height: 300.0,)
                        : Image.file(
                            _imageFile,
                            height: 300.0,
                            width: 400.0,
                          ),
                  ),
                //button to upload the user photo..
                RaisedButton(
                  elevation: 6.0,
                  color: Colors.lightBlue,
                  child: Text('Upload My Photo'),
                  onPressed: () {
                      if(_imageFile !=null)
                        {
                          bool status = true;
                          widget.setImageUploadedStatus(status);
                          imageId = Random().nextInt(1000000);
                          widget.setRandom(imageId);
                          final StorageReference firebaseStorageRef =
                          FirebaseStorage.instance.ref().child('${widget.idIncremental.toString()}.jpg');
                          widget.idIncremental++;
                          final StorageUploadTask task =
                          firebaseStorageRef.putFile(_imageFile);
                        }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cropImage() async {
    File cropped = await ImageCropper.cropImage(
      sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }

  void _clear() {
    setState(() {
      _imageFile = null;
    });
  }
}
