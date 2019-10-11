import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'package:kik_chat/screens/loginScreen.dart';

class Photographia extends StatefulWidget {
  @override
  _PhotographiaState createState() => _PhotographiaState();
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

  @override
  Widget build(BuildContext context) {
    String falseText= '';
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
                    if (_imageFile != null) {
                      final StorageReference firebaseStorageRef =
                          FirebaseStorage.instance.ref().child('myimage.jpg');

                      final StorageUploadTask task =
                          firebaseStorageRef.putFile(_imageFile);
                      //TODO when the upload operation done, the user should go back to the sign up not the sign in...
                    } else falseText = 'No Image selected!';
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
