import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';
import '../service/weather_service.dart';


class WeatherProvider extends ChangeNotifier {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final WeatherService _weatherService = WeatherService();
  //Map<String, dynamic>? _weatherData;
  //Listing for real-time weather updates
  // void ListenForWeatherUpdates(String city) {
  //   _db.collection('weather').doc(city).snapshots().listen((snapshot) {
  //     if (snapshot.exists) {
  //       weatherData = snapshot.data();
  //       notifyListeners();
  //     }
  //   });
  // }

  WeatherModel? _weather;
  bool _isLoading = false;
  String _city = "San Francisco";
  Map<String, dynamic>? _weatherData;


  Map<String, dynamic>? get weatherData => _weatherData;
  //bool isLoading = _isLoadiing;
  String get city => _city;
  WeatherModel? get weather => _weather;
  bool get isLoading => _isLoading;

  WeatherProvider() {
    fetchWeather(_city);
    ListenForWeatherUpdates();
  }

  //Feetching data from Api
  Future<void> fetchWeather(String city) async {
    _isLoading = true;
    notifyListeners();

    const String apiKey = "9d678bb40a028c17b31a82e35a0d24dd";
    final String url = "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric";

    final data = await WeatherService().getWeather(city);

    if (data != null) {
      _weather = WeatherModel.fromJson(data);
    }


    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _weatherData = data;
        _city = city;

        //Saving the search city to Firestore
        await _db.collection('search_cities').doc('current_weather').set({
          'city': city,
          'searched_at': FieldValue.serverTimestamp(),
        });
        
        await _db.collection('weather').doc('current_weather').set({
          'city': city,
          'temperature': data['main']['temp'],
          'humidity': data['main']['humidity'],
          'description': data['main'][0]['description'],

        });

      } else {
        print("Failed to fetch weather: ${response.body}");
      }
    } catch (e) {
      print ("Error fetching weather: $e");
    } finally {
        _isLoading = false;
        notifyListeners();
      }
    }

    // Listing for Real-Time Weather Updates from Firestore
    void ListenForWeatherUpdates() {
      _db.collection("weather").doc("current_weather").snapshots().listen((snapshot)  {
        if (snapshot.exists) {
          _weatherData = snapshot.data();
          notifyListeners();
        }
    });
  }
}