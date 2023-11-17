import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hongdou_app/model/screen_size.dart';
import 'package:hongdou_app/util/assets.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer(
      {super.key,
      required this.height,
      required this.maxHeight,
      required this.width});

  final double height;
  final double maxHeight;
  final double width;

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  double width = 0;
  late double currentHeight;
  late double currentMaxHeight;
  double opacity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      width = widget.width;
    });
  }

  @override
  void didUpdateWidget(covariant BottomContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    animationOption();
  }

  /// title 透明渐变动画
  void animationOption() async {
    if (widget.maxHeight - widget.height <= 20) {
      setState(() {
        opacity = 1;
      });
    } else {
      setState(() {
        opacity = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          width: width,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: const Duration(milliseconds: 300),
            child: const Image(
              width: double.infinity,
              image: AssetImage(Assets.bg20),
            ),
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.w),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            childAspectRatio: 2,
            mainAxisSpacing: 20,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            children: const [
              MenuCard(),
              MenuList(),
            ],
          ),
        )
      ],
    );
  }
}

/// 菜单卡片
class MenuCard extends StatefulWidget {
  const MenuCard({super.key});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  double screenWidth = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final screenSize = ScreenSize.fromMediaQueryData(MediaQuery.of(context));
    setState(() {
      screenWidth = screenSize.screenWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 12.w,
      childAspectRatio: 1.0,
      padding: EdgeInsets.zero,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(12.w),
            ),
            boxShadow: const [
              BoxShadow(
                  color: Assets.colorGray4, offset: Offset(0, 2), blurRadius: 6)
            ],
            gradient: const LinearGradient(
              colors: [Colors.white, Color(0xffFFA59F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(12.w),
            ),
            child: Stack(
              children: [
                Positioned(
                  bottom: -12.h,
                  right: -24.h,
                  child: Transform.rotate(
                    angle: 100,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [Colors.black.withOpacity(0.2), Colors.black],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset(
                        Assets.loveList,
                        width: 140.w,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "恋爱清单",
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color(0xffFA7079),
                        ),
                      ),
                      Text(
                        "已打卡 0/100",
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xffFA7079),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 8.h),
                        padding: EdgeInsets.symmetric(
                            vertical: 2.h, horizontal: 6.w),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.5.w,
                            color: const Color(0xffFA7079),
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          '去打卡',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xffFA7079),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: double.infinity,
              height: ((screenWidth - 36.w) / 4) - 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.w),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Assets.colorGray4,
                      offset: Offset(0, 2),
                      blurRadius: 6)
                ],
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xffFFD9B7)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.h,
                    right: 12.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Assets.colorWaring.withOpacity(0.6),
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        Assets.integratingPlate,
                        width: 32.w,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(top: 4.w, left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "积分板",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xffFF9B43),
                          ),
                        ),
                        Text(
                          "520",
                          style: TextStyle(
                            fontSize: 30.sp,
                            color: const Color(0xffFF9B43),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: ((screenWidth - 36.w) / 4) - 6,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(12.w),
                ),
                boxShadow: const [
                  BoxShadow(
                      color: Assets.colorGray4,
                      offset: Offset(0, 2),
                      blurRadius: 6)
                ],
                gradient: const LinearGradient(
                  colors: [Colors.white, Color(0xff9BBCFF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 12.h,
                    right: 12.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        boxShadow: [
                          BoxShadow(
                            color: Assets.colorBlue.withOpacity(0.6),
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: Image.asset(
                        Assets.shop,
                        width: 36.w,
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: double.infinity,
                    padding: EdgeInsets.only(top: 4.w, left: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "积分商店",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff0256FF),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 8.h),
                          padding: EdgeInsets.symmetric(
                              vertical: 2.h, horizontal: 6.w),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 0.5.w,
                              color: const Color(0xff0256FF),
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '去打卡',
                            style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color(0xff0256FF),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

/// 菜单列表
class MenuList extends StatefulWidget {
  const MenuList({super.key});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  // 菜单列表
  final List menuList = [
    {
      "name": '恋爱笔记',
      "icon": Assets.loveDiary,
    },
    {
      "name": '惊喜情书',
      "icon": Assets.loveLetter,
    },
    {
      "name": '纪恋日',
      "icon": Assets.commemorationDay,
    },
    {
      "name": '姨妈助手',
      "icon": Assets.periods,
    },
    {
      "name": '情侣厨房',
      "icon": Assets.dishes,
    },
    {
      "name": '备忘录',
      "icon": Assets.memo,
    },
    {
      "name": '查看距离',
      "icon": Assets.location,
    },
    {
      "name": '大转盘',
      "icon": Assets.slyderAdventures,
    },
    {
      "name": '时光相册',
      "icon": Assets.slyderAdventures,
    },
  ];

  final int itemsPerPage = 8; // 每页显示的菜单数量
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    int totalPages = (menuList.length / itemsPerPage).ceil(); // 总页数

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: PageView.builder(
            itemCount: totalPages,
            itemBuilder: (context, pageIndex) {
              int startIndex = pageIndex * itemsPerPage;
              int endIndex = (startIndex + itemsPerPage) < menuList.length
                  ? (startIndex + itemsPerPage)
                  : menuList.length;

              List<Widget> pageItems =
                  menuList.sublist(startIndex, endIndex).map((menu) {
                return Column(
                  children: [
                    Image(
                      height: 28.w,
                      image: AssetImage(menu['icon']),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      menu['name'],
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                );
              }).toList();

              return GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
                crossAxisSpacing: 12.w,
                mainAxisSpacing: 12.w,
                childAspectRatio: 1.2,
                padding: EdgeInsets.only(top: 12.w),
                children: pageItems,
              );
            },
            onPageChanged: (value) {
              setState(() {
                currentPage = value;
              });
            },
          ),
        ),
        SizedBox(
          height: 10.h,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: getPageDot(totalPages),
          ),
        )
      ],
    );
  }

  List<Widget> getPageDot(total) {
    List<Widget> list = [];
    for (int i = 0; i < total; i++) {
      list.add(AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 4.h,
        width: currentPage == i ? 16.w : 6.w,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(2.w)),
      ));
    }
    return list;
  }
}
