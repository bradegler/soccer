import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart';

class ImageRepository {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<String> saveImage(Image image) async {
    var thumbnail = copyResize(image, 128, 128);
    var path = await _localPath;
    var file = File('$path/${DateTime.now().toUtc().toIso8601String()}.png');
    file.writeAsBytesSync(encodePng(thumbnail));
    return file.path;
  }

  Future<Image> loadImage(String filePath) async {
    if (filePath == null) {
      return Future.value(null);
    }
    File file = File(filePath);
    Image image = decodeImage(file.readAsBytesSync());
    return Future.value(image);
  }
}
