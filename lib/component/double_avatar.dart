import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/util/assets.dart';

class DoubleAvatar extends StatefulWidget {
  DoubleAvatar(
      {super.key,
      required this.myAvatar,
      required this.taAvatar,
      this.online,
      this.size});
  final String myAvatar;
  final String taAvatar;
  bool? online = null;
  double? size = 52.w;

  @override
  State<DoubleAvatar> createState() => _DoubleAvatarState();
}

class _DoubleAvatarState extends State<DoubleAvatar> {
  @override
  Widget build(BuildContext context) {
    final headerWidth = widget.size! * 2 - 6;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: headerWidth,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      image: const AssetImage(Assets.women),
                      width: widget.size,
                      height: widget.size,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.w, color: Colors.white),
                    borderRadius: BorderRadius.circular(60),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image(
                      image: const AssetImage(Assets.men),
                      width: widget.size,
                      height: widget.size,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 2,
                right: (widget.size! / 8),
                child: Container(
                  height: 10.w,
                  width: 10.w,
                  decoration: BoxDecoration(
                    // color: Colors.black26,
                    color: Assets.colorCyan,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
