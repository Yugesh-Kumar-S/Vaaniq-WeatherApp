import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorWidget extends StatelessWidget {
  final String message;

  const ErrorWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenHeight = constraints.maxHeight;
        final screenWidth = constraints.maxWidth;

        final iconSize = (screenHeight * 0.08).clamp(48.0, 80.0);
        final titleFontSize = (screenWidth * 0.045).clamp(16.0, 24.0);
        final messageFontSize = (screenWidth * 0.035).clamp(14.0, 18.0);

        return Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: screenHeight * 0.3,
                maxWidth: screenWidth * 0.9,
              ),
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: iconSize,
                      color: Colors.deepOrange,
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    Flexible(
                      child: Text(
                        'Oops! Something went wrong',
                        style: GoogleFonts.poppins(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.01),

                    Flexible(
                      child: Text(
                        message,
                        style: GoogleFonts.poppins(
                          fontSize: messageFontSize,
                          color: Colors.grey[600],
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
