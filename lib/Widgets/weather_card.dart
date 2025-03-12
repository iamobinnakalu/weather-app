import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../appColor/app_color.dart';

class WeatherCard extends StatelessWidget {
  final String time;
  final String temperature;
  final IconData? icon;
  final String condition;

  const WeatherCard({
    super.key,
    required this.time,
    required this.temperature,
    this.icon,
    required this.condition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
                time, style: GoogleFonts.poppins(color: AppColors.textColor, fontSize: 18, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(getRandomTemperature(), style: GoogleFonts.poppins(color: AppColors.textColor,fontSize: 24, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
          //Icon(icon, size: 50),
          ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 50,
              maxHeight: 50,
            ),
            child: Image.asset(
              getRandomImage(),
              height: 50,
              width: 50,
              //fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}

//For Random selections of images
String getRandomImage() {
  return weatherImages[Random().nextInt(weatherImages.length)];
}

//For Random generation of temperature
String getRandomTemperature() {
  return "${20 + Random().nextInt(21)}°C";
}

List<String> weatherImages = [
  'assets/images/01d.png',
  'assets/images/02d.png',
  'assets/images/03d.png',
  'assets/images/04d.png',
  'assets/images/09d.png',
  'assets/images/10d.png',
  'assets/images/11d.png',
  'assets/images/13d.png',
  'assets/images/50d.png',
];

