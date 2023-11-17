import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CalculateTime extends StatefulWidget {
  const CalculateTime({super.key, required this.day});

  final int day;

  @override
  State<CalculateTime> createState() => _CalculateTimeState();
}

class _CalculateTimeState extends State<CalculateTime> {
  String days = '00';
  String hours = '00';
  String minutes = '00';
  String seconds = '00';
  late Timer _timer;
  init() {
    DateTime currentTime = DateTime.now();
    DateTime targetTime =
        DateTime.fromMillisecondsSinceEpoch(widget.day * 1000);
    Duration difference = currentTime.difference(targetTime);
    setState(() {
      days = "${difference.inDays}".padLeft(2, '0');
      hours = "${difference.inHours % 24}".padLeft(2, '0');
      minutes = "${difference.inMinutes % 60}".padLeft(2, '0');
      seconds = "${difference.inSeconds % 60}".padLeft(2, '0');
    });
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      init();
    });
  }

  @override
  void deactivate() {
    _timer.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "第",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "$days",
          style: TextStyle(
            fontSize: 32.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "天",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "$hours",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "小时",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "$minutes",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "分钟",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "$seconds",
          style: TextStyle(
            fontSize: 20.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
        Text(
          "秒",
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(0, 2),
                blurRadius: 4,
                color: Colors.black.withOpacity(0.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
