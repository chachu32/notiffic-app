import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
 // Import the image upload page

class ImageListScree extends StatefulWidget {
  @override
  _ImageListScreeState createState() => _ImageListScreeState();
}

class _ImageListScreeState extends State<ImageListScree> {
  List<MapEntry<String, DateTime>> imageEntries = [];
  DateTime? _lastBackPressedTime;

  @override
  void initState() {
    super.initState();
    _loadImageUrls();
  }

  Future<void> _loadImageUrls() async {
    final storageRef = FirebaseStorage.instance.ref().child('images');
    final listResult = await storageRef.listAll();

    final List<MapEntry<String, DateTime>> entries = [];

    for (final ref in listResult.items) {
      final metadata = await ref.getMetadata();
      final uploadTimestamp = metadata.timeCreated;
      final imageUrl = await ref.getDownloadURL();
      entries.add(MapEntry(imageUrl, uploadTimestamp ?? DateTime.now()));
    }

    setState(() {
      imageEntries = entries;
    });
  }

  void _showFullScreenImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImageView(imageUrl: imageUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_lastBackPressedTime == null ||
            DateTime.now().difference(_lastBackPressedTime!) > Duration(seconds: 2)) {
          _lastBackPressedTime = DateTime.now();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press back again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        } else {
          Navigator.pushReplacementNamed(context, '/upload');
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Criminal List'),
        ),
        body: imageEntries.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: imageEntries.length,
                itemBuilder: (context, index) {
                  final entry = imageEntries[index];
                  return GestureDetector(
                    onTap: () => _showFullScreenImage(entry.key),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Image.network(
                            entry.key,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(entry.value.toString()),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}

class FullScreenImageView extends StatelessWidget {
  final String imageUrl;

  FullScreenImageView({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Full Screen Image'),
      ),
      body: Center(
        child: Image.network(imageUrl),
      ),
    );
  }
}
