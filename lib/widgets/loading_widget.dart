import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final bool showAnimation;

  const LoadingWidget({super.key, this.message, this.showAnimation = true});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showAnimation)
            Lottie.asset('assets/loading.json', width: 200, height: 200)
          else
            const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            message ?? 'Loading...',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
