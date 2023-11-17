import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/component/love_dating_record.dart';
import 'package:hongdou_app/component/double_avatar.dart';
import 'package:hongdou_app/util/assets.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({
    super.key,
    required this.width,
    required this.onPlay,
    required this.onVolume,
    required this.onAnchor,
  });

  final double width;
  final Function(bool) onPlay;
  final Function(bool) onVolume;

  final Function(bool) onAnchor;

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  bool openButton = false;
  bool play = true;
  bool volume = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 头部
        Container(
          height: 52.h,
          width: double.infinity,
          padding: EdgeInsets.only(left: 12.w, right: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40.w,
                child: IconButton(
                  onPressed: () {
                    widget.onAnchor(true);
                  },
                  icon: const Icon(
                    Icons.sort_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              DoubleAvatar(
                myAvatar: Assets.men,
                taAvatar: Assets.women,
                size: 44.w,
              ),
              SizedBox(width: 40.w),
            ],
          ),
        ),
        const Expanded(
          child: LoveDatingRecord(
              day: 1627504612,
              loveDeclaration: "我们要一直一直在一起",
              man: "萝茗",
              woman: "乔穗"),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 8.h),
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.room_outlined,
                    color: Colors.white,
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Text(
                    "中江 & 广安",
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: openButton ? 1 : 0.4,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: openButton ? 140.w : 52.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(23.w),
                  ),
                  child: ClipRect(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        // 展开/收起
                        IconButton(
                          onPressed: () {
                            setState(() {
                              openButton = !openButton;
                            });
                          },
                          icon: openButton
                              ? const Icon(Icons.chevron_right)
                              : const Icon(Icons.chevron_left),
                        ),
                        // 播放开关
                        Expanded(
                          child: ClipRect(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  play = !play;
                                });
                                widget.onPlay(play);
                              },
                              icon: play
                                  ? const Icon(
                                      Icons.pause,
                                      color: Assets.colorGray5,
                                    )
                                  : const Icon(
                                      Icons.play_arrow,
                                    ),
                            ),
                          ),
                        ),
                        // 声音开关
                        Expanded(
                          child: ClipRect(
                            child: IconButton(
                              onPressed: () {
                                setState(() {
                                  volume = !volume;
                                });
                                widget.onVolume(volume);
                              },
                              icon: volume
                                  ? const Icon(
                                      Icons.volume_off,
                                      color: Assets.colorGray5,
                                    )
                                  : const Icon(
                                      Icons.volume_down,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
