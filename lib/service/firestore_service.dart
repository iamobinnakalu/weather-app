import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //Saving weather data to firestore
  Future<void> saveWeatherData(String city, Map<String, dynamic> weatherData) async {
    await _db.collection('weather').doc(city).set(weatherData);
  }

  ///Getting real-time weather updates
  Stream<DocumentSnapshot> getWeatherUpdates(String city) {
    return _db.collection('weather').doc(city).snapshots();
  }
}