import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class FileConverter {
  static String getBase64StringPath(String path) {
    File file = File(path);
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }
  static String getBase64StringFile(File file) {
    List<int> fileInByte = file.readAsBytesSync();
    String fileInBase64 = base64Encode(fileInByte);
    return fileInBase64;
  }

  static Future<File> getImageFromBase64(String s) async {
    File image;
    final decodedBytes = base64Decode(s);
    final directory = await getApplicationDocumentsDirectory();
    image = File('${directory.path}/${UniqueKey()}.jpg');
    image.writeAsBytesSync(List.from(decodedBytes));
    return image;
  }
}