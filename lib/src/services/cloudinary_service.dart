
import 'package:dio/dio.dart';

class CloudinaryService{

  Future<String?> uploadImage( { required String path } ) async {

    if( path.isEmpty ){
      return '';
    }

    try {
      var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile( path ),
      });

      final response = await Dio().post(
        'https://api.cloudinary.com/v1_1/de29afdze/image/upload?upload_preset=ogvbi181',
        data: formData,
      );

      if (response.statusCode == 200) {
        return response.data["secure_url"];
      }
    } catch (e) {
      print(  e );
    }

    return '';

    // final imageRequest = http.MultipartRequest('POST', url);
    // final file = await http.MultipartFile.fromPath('file', path );
    // imageRequest.files.add( file );

    // final streamResponse = await imageRequest.send();
    // final resp = await http.Response.fromStream( streamResponse );

    // if( resp.statusCode != 200 && resp.statusCode != 201 ){
    //   return null;
    // }

    // final decodedData = json.decode( resp.body );
    // return decodedData;
    }

}