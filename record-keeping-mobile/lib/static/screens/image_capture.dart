import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'send_files.dart';

class CameraHome extends StatefulWidget {
  @override
  _CameraHomeState createState() => _CameraHomeState();
}

class _CameraHomeState extends State<CameraHome> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: InteractiveViewer(
        child: Center(
          child:
              _image == null ? Text('No image selected.') : Image.file(_image),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _image == null
            ? getImage
            : () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SendFiles(imageFile: _image)));
              },
        tooltip: 'Pick Image',
        child: Icon(
            _image == null ? Icons.add_a_photo : Icons.arrow_forward_sharp),
      ),
    );
  }
}
