import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Providers/weather_provider.dart';
import '../appColor/app_color.dart';
import '../models/weather_model.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final TextEditingController _cityController = TextEditingController();
  String weatherImage = 'assets/images/10d.png';

  void _fetchWeather(BuildContext context) async {
    final city = _cityController.text.trim();
    if (city.isNotEmpty) {
      final weatherProvider = context.read<WeatherProvider>();
      await weatherProvider.fetchWeather(city);
      final weather = weatherProvider.weather;

      // Default image
      String selectedImage = 'assets/images/10d.png';

      if (weather != null) {
        final Map<String, String> weatherImagesMap = {
          'clear': 'assets/images/01d.png',
          'clouds': 'assets/images/02d.png',
          'rain': 'assets/images/10d.png',
          'drizzle': 'assets/images/09d.png',
          'thunderstorm': 'assets/images/11d.png',
          'snow': 'assets/images/13d.png',
          'fog': 'assets/images/50d.png',
          'mist': 'assets/images/50d.png',
          'haze': 'assets/images/50d.png',
        };

        // Convert description to lowercase before lookup
        selectedImage = weatherImagesMap[weather.description?.toLowerCase()] ?? 'assets/images/10d.png';

        await FirebaseFirestore.instance.collection('searched_cities').add({
          'city': city,
          'search_at': FieldValue.serverTimestamp(),
          'temperature': weather.temperature ?? 0, // Fix null issue
          'description': weather.description ?? 'No description available', // Fix null issue
          'image': selectedImage, // Store the correct local image
        });
      }

      // ✅ UI Updates AFTER Firebase Write
      setState(() {
        weatherImage = selectedImage;
      });

      _cityController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Search Location',
              style: GoogleFonts.poppins(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Find the area or city you want to know\n the detailed weather info at this time',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: AppColors.primaryColor,
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _cityController,
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                      ),
                      decoration: InputDecoration(
                        labelText: 'Search',
                        suffixIcon: IconButton(
                          icon: Icon(Icons.search),
                          onPressed: () => _fetchWeather(context),
                        ),
                        hintStyle: GoogleFonts.poppins(
                          color: Colors.black,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),

            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('searched_cities')
                    .orderBy('search_at', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text('No recent searches'));
                  }

                  var cities = snapshot.data!.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

                  return GridView.builder(
                    itemCount: cities.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final city = cities[index];

                      return Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              city['image'] ?? 'assets/images/10d.png',
                              height: 200,
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              city['city'],
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${city['temperature']}°C',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              city['description'] ?? 'Unknown',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WeatherCard extends StatelessWidget {
  final WeatherModel weather;

  const WeatherCard({required this.weather, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            weather.cityName,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Center(
            child: Image.asset(
              weather.icon ?? 'assets/images/10d.png',
              height: 150,
              width: 150,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Temp: ${weather.temperature}°C",
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            weather.description,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}