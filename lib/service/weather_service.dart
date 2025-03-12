import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  static const String apiKey = "c2a57213ee62ca6910c399f70b4f8686";
  static const String apiUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>?> getWeather(String city) async {
    final url = Uri.parse('$apiUrl?q=$city&appid=$apiKey&units=metric');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Error: ${response.body}');
        return null;
      }
    } catch (e) {
      print('Network error: $e');
      return null;
    }
  }
}