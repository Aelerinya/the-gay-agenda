import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:the_gay_agenda/services/user.dart';

class ProfilePicturePicker extends StatefulWidget {
  final User user;
  const ProfilePicturePicker({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  _ProfilePicturePickerState createState() => _ProfilePicturePickerState();
}

enum ImageSourceType { gallery, camera }

class _ProfilePicturePickerState extends State<ProfilePicturePicker> {
  final _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
            width: 200,
            height: 200,
            child: CircleAvatar(
                foregroundImage: widget.user.imagePath != ''
                    ? Image.file(File(widget.user.imagePath)).image
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
                    widget.user.imagePath = image!.path;
                    widget.user.save();
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
                      widget.user.imagePath = image!.path;
                      widget.user.save();
                    });
                  },
                  child: const Text('From Camera')),
            ])),
      ],
    );
  }
}
