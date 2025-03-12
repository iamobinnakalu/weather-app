import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{

  final Size preferredSize;

  CustomAppBar({Key? key})
    : preferredSize = Size.fromHeight(130),
    super(key: key);

  String getCurrentTime() {
    return DateFormat('MMM dd, yyyy').format(DateTime.now());
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: PreferredSize(
          preferredSize: preferredSize,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //SizedBox(height: 10),
            Text(
                'Weekly Forecast',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today',
                    style: GoogleFonts.poppins(
                        fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                  getCurrentTime(),
                    style: GoogleFonts.poppins(
                        fontSize: 18
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}