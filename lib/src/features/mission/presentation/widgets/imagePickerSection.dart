import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImagePickerPage extends StatefulWidget {
  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  List<File?> _images = [];

  Future<void> _getImage(ImageSource source) async {
    final XFile? image = await ImagePicker().pickImage(source: source);

    if (image != null) {
      setState(() {
        _images.add(File(image.path));
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: _images.asMap().entries.map((entry) {
            final int index = entry.key;
            final File? image = entry.value;

            return Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                if (image != null)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(image, width: 100, height: 100),
                  )
                else
                  Container(), // Görsel yoksa boş bir konteyner
                IconButton(
                  icon: Icon(Icons.close, color: Colors.red),
                  onPressed: () => _removeImage(index),
                ),
              ],
            );
          }).toList(),
        ),
        ElevatedButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SafeArea(
                  child: Wrap(
                    children: <Widget>[
                      ListTile(
                        leading: Icon(Icons.photo_library),
                        title: Text('Galeriden Yükle'),
                        onTap: () {
                          _getImage(ImageSource.gallery);
                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text('Kameradan Çek'),
                        onTap: () {
                          _getImage(ImageSource.camera);
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Text('Resim Ekle'),
        ),
      ],
    );
  }
}
