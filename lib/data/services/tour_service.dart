import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mini_tour_booking_app/domain/tour_model.dart';

class TourService {
  Future<List<TourModel>> getTours() async {
    final url = Uri.parse(
      'https://api.jsonbin.io/v3/b/686561518960c979a5b5f282',
    );
    final response = await http.get(
      url,
      headers: {
        'X-Master-Key':
            r'$2a$10$Yx8/zqpRjmwYrVjb74b0Y.xztTX2St11BCPLaMKJdvbF2DsjtaTx6',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> records = data['record'];
      return records.map((json) => TourModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tours');
    }
  }
}
