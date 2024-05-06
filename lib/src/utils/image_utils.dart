

import 'package:image_picker/image_picker.dart';

class ImageUtils{

  static Future<List<XFile>>pickMultiImage()async{
    return await ImagePicker().pickMultiImage();
  }

  static Future<XFile?> pickImageWithCamera() async {
    return await ImagePicker().pickImage(source: ImageSource.camera );
  }

  static Future<XFile?> pickImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery );
  }

}