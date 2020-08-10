import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class Locatedfile {
  final PickedFile pickedFile;
  final Position position;

  Locatedfile(this.pickedFile, this.position);
}
