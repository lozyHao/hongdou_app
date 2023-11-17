import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/model/screen_size.dart';
import 'package:hongdou_app/page/home/component/bottom_container.dart';
import 'package:hongdou_app/page/home/component/home_drawer.dart';
import 'package:hongdou_app/page/home/component/top_container.dart';
import 'package:hongdou_app/util/assets.dart';
import 'package:video_player/video_player.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double minHeight = 188.w;
  double maxHeight = 450.w;
  double currentHeight = 188.w;

  bool isDrag = false;
  double screenWidth = 0;
  double statusBarHeight = 0;
  double bottomBarHeight = 0;

  late VideoPlayerController _videoController;

  // 控制侧边栏
  late bool showNavigationDrawer;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(Assets.vlog)
      ..initialize().then((_) {
        _videoController.setLooping(true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = ScreenSize.fromMediaQueryData(MediaQuery.of(context));
    setState(() {
      screenWidth = screenSize.screenWidth;
      statusBarHeight = screenSize.statusBarHeight;
      bottomBarHeight = screenSize.bottomBarHeight;

      minHeight = screenWidth / 2 + 24.w + bottomBarHeight;
      maxHeight = screenWidth + 48.w;
      if (bottomBarHeight > 0) {
        minHeight = screenWidth / 2 + bottomBarHeight;
      }
      currentHeight = minHeight;
    });
  }

  /// 侧边栏
  void setAnchor(status) {
    scaffoldKey.currentState!.openDrawer();
  }

  /// 设置声音开关
  void setVideoVolume(status) {
    if (status) {
      _videoController.setVolume(1.0);
    } else {
      _videoController.setVolume(0.0);
    }
  }

  /// 设置视频开关
  void setVideoPlay(status) {
    // 设置音量为0.0（静音）
    if (status) {
      _videoController.play();
    } else {
      _videoController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  // 此处可以是图片，也可以是 Vlog 视频
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        image: AssetImage(Assets.homeMainImage),
                      ),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: _videoController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: _videoController.value.aspectRatio,
                                child: VideoPlayer(_videoController),
                              )
                            : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(top: statusBarHeight),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          // 顶部内容组件
                          child: TopContainer(
                            width: screenWidth,
                            onPlay: setVideoPlay,
                            onVolume: setVideoVolume,
                            onAnchor: setAnchor,
                          ),
                        ),
                        Listener(
                          onPointerDown: (event) {
                            isDrag = true;
                          },
                          onPointerUp: (event) {
                            if (currentHeight <
                                minHeight + (maxHeight - minHeight) / 2) {
                              setState(() {
                                currentHeight = minHeight;
                                isDrag = false;
                              });
                            }
                            if (currentHeight >
                                minHeight + (maxHeight - minHeight) / 2) {
                              setState(() {
                                currentHeight = maxHeight;
                                isDrag = false;
                              });
                            }
                          },
                          onPointerMove: (PointerMoveEvent event) {
                            final double = event.delta.dy;
                            if (double < 0) {
                              if (currentHeight <= maxHeight) {
                                setState(() {
                                  currentHeight =
                                      currentHeight - event.delta.dy;
                                });
                              }
                            } else {
                              if (currentHeight >= minHeight) {
                                setState(() {
                                  currentHeight =
                                      currentHeight - event.delta.dy;
                                });
                              }
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            height: 24.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(24.w),
                                topRight: Radius.circular(24.w),
                              ),
                            ),
                            child: UnconstrainedBox(
                              child: Container(
                                width: 60.w,
                                height: 4.h,
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: Assets.colorGray4,
                                  borderRadius: BorderRadius.circular(2.w),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Listener(
              onPointerDown: (event) {
                isDrag = true;
              },
              onPointerUp: (event) {
                if (currentHeight < minHeight + (maxHeight - minHeight) / 2) {
                  setState(() {
                    currentHeight = minHeight;
                    isDrag = false;
                  });
                }
                if (currentHeight > minHeight + (maxHeight - minHeight) / 2) {
                  setState(() {
                    currentHeight = maxHeight;
                    isDrag = false;
                  });
                }
              },
              onPointerMove: (PointerMoveEvent event) {
                final double = event.delta.dy;
                if (double < 0) {
                  if (currentHeight <= maxHeight) {
                    setState(() {
                      currentHeight = currentHeight - event.delta.dy;
                    });
                  }
                } else {
                  if (currentHeight >= minHeight) {
                    setState(() {
                      currentHeight = currentHeight - event.delta.dy;
                    });
                  }
                }
                // print("x:${event.delta.dx}--y:${event.delta.dy}");
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: isDrag == true ? 0 : 200),
                curve: Curves.easeInOut,
                height: currentHeight,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                // 内容组件
                child: BottomContainer(
                  height: currentHeight,
                  width: screenWidth,
                  maxHeight: maxHeight,
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: HomeDrawer(statusBarHeight: statusBarHeight),
    );
  }
}
