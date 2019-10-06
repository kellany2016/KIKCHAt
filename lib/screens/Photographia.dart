import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file/file.dart';

class Photographia extends StatefulWidget {
  @override
  _PhotographiaState createState() => _PhotographiaState();
}

class _PhotographiaState extends State<Photographia> {
  File _imageFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.camera),
              onPressed: ()=> _pickImage(ImageSource.camera),
            ),
            IconButton(
              icon: Icon(Icons.photo_library),
              onPressed: ()=> _pickImage(ImageSource.gallery),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _pickImage(ImageSource source) async{
    File selected = await ImagePicker.pickImage(source: source);
    setState(() {
      _imageFile = selected;
    });
  }

  Future<void> _cropImage() async
  {
    File cropped = await ImageCropper.cropImage(
        sourcePath: _imageFile.path,
    );
    setState(() {
      _imageFile = cropped ?? _imageFile;
    });
  }
  void _clear(){
    setState(() {
      _imageFile = null;
    });
  }
}
