import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/page/home/home.dart';
import 'package:hongdou_app/util/assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _positionAnimation;
  double opacity = 0;

  @override
  void initState() {
    super.initState();
    animationOption();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  /// title 透明渐变动画
  void animationOption() async {
    // 初始化动画控制器
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // 动画结束后延时跳转
          Future.delayed(const Duration(seconds: 3), navigateToNextScreen);
        }
      });
    // 创建透明度动画
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInCirc,
      ),
    )..addListener(() {
        setState(() {
          opacity = _opacityAnimation.value;
        });
      });
    // 创建位置动画
    _positionAnimation = Tween<Offset>(
      begin: const Offset(0.0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    // 触发动画的播放
    await Future.delayed(const Duration(seconds: 1));
    _animationController.forward();
  }

  /// 路由跳转
  void navigateToNextScreen() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Home()),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(Assets.splashScreenBg))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Opacity(
                    opacity: opacity,
                    child: SlideTransition(
                      position: _positionAnimation,
                      child: Image(
                        height: 200.h,
                        image: const AssetImage(
                          Assets.splashScreenTitle,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                    height: 60.h,
                    image: const AssetImage(Assets.logoIconRound)),
                SizedBox(
                  height: 24.h,
                ),
                Image(
                    width: 160.w,
                    image: const AssetImage(Assets.splashScreenNotice)),
                SizedBox(
                  height: 28.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
