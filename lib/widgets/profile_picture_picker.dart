import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicturePicker extends StatefulWidget {
  const ProfilePicturePicker({Key? key}) : super(key: key);

  @override
  _ProfilePicturePickerState createState() => _ProfilePicturePickerState();
}

enum ImageSourceType { gallery, camera }

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  var _image = File('');
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 200,
            height: 200,
            child: CircleAvatar(
                foregroundImage: _image != File('')
                    ? Image.file(_image).image
                    : const NetworkImage(''),
                backgroundImage: const NetworkImage(
                    'https://cdn-icons-png.flaticon.com/512/20/20079.png'))),
        Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Column(children: [
              const Text('New Profile Image:'),
              ElevatedButton(
                onPressed: () async {
                  XFile? image = await _imagePicker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 50,
                      preferredCameraDevice: CameraDevice.front);
                  setState(() {
                    _image = File(image!.path);
                  });
                },
                child: const Text('From Gallery'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    XFile? image = await _imagePicker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 50,
                        preferredCameraDevice: CameraDevice.front);
                    setState(() {
                      _image = File(image!.path);
                    });
                  },
                  child: const Text('From Camera')),
            ])),
      ],
    );
  }
}
