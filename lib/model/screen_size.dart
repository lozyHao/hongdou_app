import 'package:flutter/material.dart';

class ScreenSize {
  final double screenWidth;
  final double screenHeight;
  final double statusBarHeight;
  final double bottomBarHeight;
  final double allHeight;
  final double availableHeight;

  ScreenSize({
    required this.screenWidth,
    required this.screenHeight,
    required this.statusBarHeight,
    required this.bottomBarHeight,
    required this.allHeight,
    required this.availableHeight,
  });

  factory ScreenSize.fromMediaQueryData(MediaQueryData data) {
    final screenWidth = data.size.width;
    final screenHeight = data.size.height;
    final statusBarHeight = data.padding.top;
    final bottomBarHeight = data.padding.bottom;
    final allHeight = screenHeight + statusBarHeight + bottomBarHeight;
    final availableHeight = screenHeight - statusBarHeight - bottomBarHeight;

    return ScreenSize(
      screenWidth: screenWidth,
      screenHeight: screenHeight,
      statusBarHeight: statusBarHeight,
      bottomBarHeight: bottomBarHeight,
      allHeight: allHeight,
      availableHeight: availableHeight,
    );
  }
}
