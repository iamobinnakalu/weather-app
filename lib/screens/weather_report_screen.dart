import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../Providers/weather_provider.dart';
import '../appColor/app_color.dart';
import '../models/weather_model.dart';
import '../service/weather_service.dart';
import 'location_screen.dart';


class WeatherReportScreen extends StatefulWidget {
  const WeatherReportScreen({super.key});

  @override
  State<WeatherReportScreen> createState() => _WeatherReportScreenState();
}

class _WeatherReportScreenState extends State<WeatherReportScreen> {

  final WeatherService _weatherService = WeatherService();
  String city = "San Francisco";
  String weatherImage = 'assets/images/10d.png';
  Map<String, dynamic>? weatherData;
  bool isLoading = true;
  int _selectedIndex = 0;

  final List<String> cities = [ "San Francisco", "New York", "Lagos", "Aba", "Abuja", "Paris", "Spain", "Jos"];

  final List<String> weatherImages = [
    'assets/images/10d.png',
    'assets/images/11d.png',
    'assets/images/13d.png',
    'assets/images/50d.png',
    'assets/images/01d.png',
    'assets/images/02d.png',
  ];

  // @override
  // Widget build(BuildContext context) {
  //   final weatherProvider = context.watch<WeatherProvider>();
  //   final weatherData = weatherProvider.weatherData;
  // }

  @override
  void initState() {
    super.initState();
    _randomizeCity();
    _randomizeImage();
    fetchWeather();
    //Listing for firebase updates
    Provider.of<WeatherProvider>(context, listen: false).ListenForWeatherUpdates();
  }

  String getCurrentTime() {
    return DateFormat('MMM dd, yyyy').format(DateTime.now());
  }

  void _randomizeCity() {
    final random = Random();
    city = cities[random.nextInt(cities.length)];
  }
  void _randomizeImage() {
    final random = Random();
    weatherImage = weatherImages[random.nextInt(weatherImages.length)];
  }

  Future<void> _navigateToLocationScreen() async {
    final selectedCity = await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LocationScreen())
    );

    if (selectedCity != null && selectedCity is String) {
      setState(() {
        city = selectedCity;
        fetchWeather();
      });

      context.read<WeatherProvider>().fetchWeather(city);
    }
  }

  Future<void> fetchWeather() async {
    setState(() => isLoading = true
    );

    try {
      final data = await _weatherService.getWeather(city);
      if (mounted) {
        setState(() {
          weatherData = data;
          _randomizeImage();
          isLoading = false;
        });
      }

    } catch (e) {
      if (mounted) {
        setState(() => isLoading = false
        );
      }
    }

  }
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    final weatherProvider = context.watch<WeatherProvider>();
    final weatherData = weatherProvider.weatherData;

    return Scaffold(
      appBar: AppBar(
      ),

      body: isLoading || weatherData == null
          ? Center(child: CircularProgressIndicator())
          // : weatherData == null
          // ? Center(child: Text('Failed to fetch weather data'))
          :
      //SingleChildScrollView(
      //Center(
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              city,
              //'${weatherData!['name']}',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
               getCurrentTime(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Forecast',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      color: AppColors.btn2Color,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        'Air quality',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              width: 300,
              child: Image.asset(
                  weatherImage,
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Today',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'View full report',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    width: 170,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: index % 2 == 0
                          ? AppColors.primaryColor
                          : AppColors.btn2Color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              weatherImage,
                              height: 60,
                              width: 60,
                            ),
                            //SizedBox(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  '${weatherData!['wind']['speed']} km/h',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '${weatherData!['main']['humidity']}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

class WeatherDetail extends StatelessWidget {
  final String label;
  final String value;

  const WeatherDetail({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
        SizedBox(width: 10),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}