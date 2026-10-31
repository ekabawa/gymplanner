
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/wger_exercise.dart';

class WgerApiService {
  static const String _baseUrl = 'https://wger.de/api/v2';

  Future<List<WgerExercise>> getExercises() async {
    final url = Uri.parse(
      '$_baseUrl/exerciseinfo/?language=2&limit=20',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> results = data['results'];

        return results
            .map((item) => WgerExercise.fromJson(item))
            .toList();
      } else {
        throw Exception(
          'Gagal mengambil data latihan: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
