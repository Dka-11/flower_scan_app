// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class PredictionService {
//   static const String apiUrl = 'http://127.0.0.1:5000/Upload';

//   static Future<String?> predictImage(File image) async {
//     final request = http.MultipartRequest(
//       'POST',
//       Uri.parse(apiUrl),
//     );
//     request.files.add(await http.MultipartFile.fromPath('file', image.path));
//     final response = await request.send();

//     if (response.statusCode == 200) {
//       final res = await http.Response.fromStream(response);
//       final data = json.decode(res.body);
//       return data['prediction'];
//     } else {
//       print('Failed to predict image.');
//       return null;
//     }
//   }
// }

import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PredictionService {
  static const String localApiUrl = 'http://192.168.127.6:5000/Upload';

  // Link URL :
  // Wifi (JTI-Polinema) :  http://192.168.56.17:5000 
  // LAN Rumah : 172.26.64.1

  static const String gcpApiUrl = 'https://flowers-api-do6lrlvoia-et.a.run.app/Upload'; // Replace with actual GCP URL

  static Future<Map<String, dynamic>?> predictImage(File image, {bool useLocal = true}) async {
    final String apiUrl = useLocal ? gcpApiUrl : localApiUrl;

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse(apiUrl),
      );
      request.files.add(await http.MultipartFile.fromPath('file', image.path));
      final response = await request.send();
      final res = await http.Response.fromStream(response);
      final data = json.decode(res.body);

      if (response.statusCode == 200) {
        return {
          'code': response.statusCode,
          'accuracy': data['accuracy'],
          'classificationResult': data['classification result'],
        };
      } else {
        print('Failed to predict image with status code: ${response.statusCode}');
        return {
          'code': response.statusCode,
          'error': data['error'],
        };
      }
    } catch (e) {
      print('Failed to predict image with error: $e');
      return null;
    }
  }
}