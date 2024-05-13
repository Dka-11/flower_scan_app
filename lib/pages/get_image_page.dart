import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class GetImage{
  Future<File?> getImageFromGallery(BuildContext context) async{
    final imageFIle = await ImagePicker().pickImage(source: ImageSource.gallery);
    return File(imageFIle!.path);
  }
}