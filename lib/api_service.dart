import 'dart:convert';
import 'package:http/http.dart' as http;

class ZodiacService {
  final String apiUrl = 'https://script.google.com/macros/s/AKfycbywRYYUjvLXuKA0Ad2CUJta3lRDA6RTtHMzWMmFY9jaPzqa9WdWgO9iROHQxi_L9qqK/exec';

  Future<Map<String, dynamic>> fetchZodiacData() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load zodiac data');
    }
  }
}
