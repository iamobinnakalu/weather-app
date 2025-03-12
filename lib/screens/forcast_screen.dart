import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Widgets/custom_appbar.dart';
import '../Widgets/weather_card.dart';
import '../appColor/app_color.dart';

class ForeCastScreen extends StatelessWidget {
  const ForeCastScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 0.0, right: 10.0, bottom: 0.0),
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 150,
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? AppColors.primaryColor
                            : AppColors.btn2Color,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/10d.png',
                              height: 60,
                              width: 60,
                            ),
                            //SizedBox(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '14.00',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textColor,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '32°C',
                                  style: GoogleFonts.poppins(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textColor,
                                  ),
                                ),
                              ],
                            ),
                            //SizedBox(height: 1),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 10),

            WeatherCard(time: 'Monday',temperature: getRandomTemperature(), condition: getRandomImage()),
            WeatherCard(time: 'Tuesday', temperature: '28',  condition: 'cloudy',),
            WeatherCard(time: 'Wednesday', temperature: '25',  condition: 'rainy',),
            WeatherCard(time: 'Thursday', temperature: '27',  condition: 'storm',),
            WeatherCard(time: 'Friday', temperature: '31',  condition: 'snow',),
            WeatherCard(time: 'Saturday', temperature: '29',  condition: 'fog',),
            WeatherCard(time: 'Sunday', temperature: '26',  condition: 'sunny',),
          ],
        ),
      ),
    );
  }
}