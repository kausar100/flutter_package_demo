import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            "Take Picture",
            textAlign: TextAlign.center,
          ),
        ),
        body: SafeArea(
          top: true,
          bottom: true,
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    height: MediaQuery.of(context).size.height* 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: imageFile == null
                          ? Image.asset("images/ic_business.png")
                          : Image.file(File(imageFile!.path)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                    onPressed: () {
                      _settingModalBottomSheet(context);
                    },
                    child: const Text("Take Photo")),
              ],
            ),
          ),
        ));
  }

  //********************** IMAGE PICKER
  Future imageSelector(BuildContext context, String pickerType) async {
    switch (pickerType) {
      case "gallery":

        /// GALLERY IMAGE PICKER
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.gallery, imageQuality: 90);
        break;

      case "camera": // CAMERA CAPTURE CODE
        imageFile = await ImagePicker()
            .pickImage(source: ImageSource.camera, imageQuality: 90);
        break;
    }

    if (imageFile != null) {
      debugPrint("You selected  image : ${imageFile!.path}");
      setState(() {});
    } else {
      debugPrint("You have not taken image");
    }
  }

  // Image picker
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(8.0),
            height: MediaQuery.of(context).size.height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.image),
                        SizedBox(height: 4.0),
                        Text('Gallery'),
                      ],
                    ),
                    onPressed: () => {
                          imageSelector(context, "gallery"),
                          Navigator.pop(context),
                        }),
                TextButton(
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt),
                      SizedBox(height: 4.0),
                      Text('Camera'),
                    ],
                  ),
                  onPressed: () => {
                    imageSelector(context, "camera"),
                    Navigator.pop(context)
                  },
                ),
              ],
            ),
          );
        });
  }
}
