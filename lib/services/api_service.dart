// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {

//   final String baseUrl = "https://template.postman-echo.com";

//   Future<Map<String, dynamic>> testPost(String name) async {

//     final response = await http.post(
//       Uri.parse("$baseUrl/post"),
//       body: {
//         "name": name,
//       },
//     );

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception("Failed request");
//     }
//   }

// }