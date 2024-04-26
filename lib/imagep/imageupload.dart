import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? _imageFile;
  DateTime? _lastPressedAt;

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageFile == null) return;
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final extension = _imageFile!.path.split('.').last;
    final destination = 'images/$fileName.$extension';
    const maxRetries = 3;
    var retryCount = 0;
    while (retryCount < maxRetries) {
      try {
        final reference = FirebaseStorage.instance.ref(destination);
        await reference.putFile(_imageFile!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Image uploaded successfully!'),
          ),
        );
        return;
      } catch (e) {
        retryCount++;
        print('Error uploading image: $e');
      }
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to upload image after $maxRetries attempts'),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastPressedAt == null ||
        now.difference(_lastPressedAt!).inSeconds > 2) {
      _lastPressedAt = now;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => ImageUpload()),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Criminal Image Upload',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color.fromARGB(255, 120, 159, 190),
          actions: [
            _ThreeDotMenu(),
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _imageFile == null
                      ? ElevatedButton.icon(
                          onPressed: _selectImage,
                          icon: Icon(Icons.image),
                          label: Text('Select Image',style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.blue,
                          ),
                        )
                      : Image.file(_imageFile!),
                  SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: _uploadImage,
                    icon: Icon(Icons.cloud_upload),
                    label: Text('Upload Image',style: TextStyle(color: Colors.white),),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThreeDotMenu extends StatelessWidget {
  const _ThreeDotMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'viewAccident',
          child: Text('View Accident'),
        ),
        PopupMenuItem<String>(
          value: 'viewCriminal',
          child: Text('View Criminal'),
        ),
        PopupMenuItem<String>(
          value: 'sendMessage',
          child: Text('Send Message'),
        ),
      ],
      onSelected: (String value) {
        if (value == 'viewAccident') {
          Navigator.pushReplacementNamed(context, '/view');
        } else if (value == 'viewCriminal') {
          Navigator.pushReplacementNamed(context, '/vie');
        } else if (value == 'sendMessage') {
          Navigator.pushReplacementNamed(context, '/message');
        }
      },
      icon: Icon(Icons.more_vert),
    );
  }
}
