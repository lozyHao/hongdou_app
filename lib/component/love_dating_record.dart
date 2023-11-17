import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/component/calculate_time.dart';
import 'package:hongdou_app/util/assets.dart';

class LoveDatingRecord extends StatefulWidget {
  const LoveDatingRecord({
    super.key,
    required this.day,
    required this.loveDeclaration,
    required this.man,
    required this.woman,
  });

  final String man;
  final String woman;
  final int day;
  final String loveDeclaration;

  @override
  State<LoveDatingRecord> createState() => _LoveDatingRecordState();
}

class _LoveDatingRecordState extends State<LoveDatingRecord> {
  late Timer _timer;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.man,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                shadows: [
                  Shadow(
                    offset: Offset(0, 2),
                    blurRadius: 4,
                    color: Colors.black.withOpacity(0.4),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            const Icon(
              Icons.favorite_outlined,
              color: Assets.colorError,
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              widget.woman,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
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
        ),
        Center(
          child: CalculateTime(day: widget.day),
        ),
        Text(
          widget.loveDeclaration,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0.sp,
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

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {});
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
