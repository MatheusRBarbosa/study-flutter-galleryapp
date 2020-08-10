import 'package:flutter/material.dart';
import 'package:galleryapp/Models/Locatedfile.dart';
import 'package:image_picker/image_picker.dart';
import 'package:galleryapp/Components/ImageTaken/ImageTaken.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(new MaterialApp(
    title: 'Camera App',
    home: LandingScreen(),
  ));
}

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final _picker = ImagePicker();
  Position actualPosition;
  PickedFile actualPickedFile;
  List<Locatedfile> imageFiles;

  @override
  void initState() {
    this.imageFiles = new List<Locatedfile>();
  }

  void _openImage(
      BuildContext context, ImageSource source, Position position) async {
    var picture = await _picker.getImage(source: source);
    Locatedfile locatedfile = new Locatedfile(picture, position);

    this.setState(() {
      this.imageFiles.add(locatedfile);
    });

    Navigator.of(context).pop();
  }

  Future<Position> _setLocation() async {
    return Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Escolha'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text('Galeria'),
                    onTap: () async {
                      Position position = await _setLocation();
                      _openImage(context, ImageSource.gallery, position);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text('Camera'),
                    onTap: () async {
                      Position position = await _setLocation();
                      _openImage(context, ImageSource.camera, position);
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget _imageView() {
    if (this.imageFiles.length == 0) {
      return Center(
        child: Text('Nenhuma imagem na Galeria'),
      );
    } else {
      return ListView.separated(
        itemCount: this.imageFiles.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return ImageTaken(this.imageFiles[index]);
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 10,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela principal')),
      body: _imageView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showChoiceDialog(context),
        child: Icon(Icons.camera, color: Colors.white),
      ),
    );
  }
}
