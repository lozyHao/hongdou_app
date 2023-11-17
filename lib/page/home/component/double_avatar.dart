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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image(
            image: AssetImage(Assets.men),
            width: widget.size,
            height: widget.size,
            fit: BoxFit.cover,
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: Image(
            image: AssetImage(Assets.women),
            width: widget.size,
            height: widget.size,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
