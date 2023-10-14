import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:point_marketing/core/constants/app_padding.dart';

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

            return Container(
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height / 5,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.grey[350], // Gri arkaplan rengi
                borderRadius: BorderRadius.circular(10.0), // Köşeleri oval yapar
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  if (image != null)
                    Padding(
                      padding: AppPadding.verticalSymmetric8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          image,
                          fit: BoxFit.cover, // Görüntüyü Container'a sığdır
                        ),
                      ),
                    ),
                  GestureDetector(
                    onTap: () => _removeImage(index),
                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
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
