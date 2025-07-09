import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final bool showAnimation;

  const LoadingWidget({super.key, this.message, this.showAnimation = true});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final availableWidth = constraints.maxWidth;

        double animationSize = _calculateAnimationSize(
          availableHeight,
          availableWidth,
        );

        double textSize = _calculateTextSize(availableHeight);

        double spacing = _calculateSpacing(availableHeight);

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (showAnimation)
                Flexible(
                  child: Lottie.asset(
                    'assets/loading.json',
                    width: animationSize,
                    height: animationSize,
                    fit: BoxFit.contain,
                  ),
                )
              else
                SizedBox(
                  width: animationSize * 0.3,
                  height: animationSize * 0.3,
                  child: const CircularProgressIndicator(strokeWidth: 3),
                ),
              SizedBox(height: spacing),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    message ?? 'Loading...',
                    style: GoogleFonts.poppins(
                      fontSize: textSize,
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  double _calculateAnimationSize(
    double availableHeight,
    double availableWidth,
  ) {
    final smallerDimension =
        availableHeight < availableWidth ? availableHeight : availableWidth;

    double size = smallerDimension * 0.6;

    return size.clamp(80.0, 200.0);
  }

  double _calculateTextSize(double availableHeight) {
    if (availableHeight < 100) {
      return 12.0;
    } else if (availableHeight < 150) {
      return 14.0;
    } else if (availableHeight < 200) {
      return 16.0;
    } else {
      return 18.0;
    }
  }

  double _calculateSpacing(double availableHeight) {
    if (availableHeight < 100) {
      return 8.0;
    } else if (availableHeight < 150) {
      return 12.0;
    } else if (availableHeight < 200) {
      return 16.0;
    } else {
      return 20.0;
    }
  }
}
