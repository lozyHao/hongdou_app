import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key, required this.statusBarHeight});

  final double statusBarHeight;

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black.withOpacity(0),
      // 自定义侧边栏
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.h,
            padding: EdgeInsets.only(top: widget.statusBarHeight),
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(12.w))),
            child: Text('头'),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 200.h,
              padding: EdgeInsets.only(top: widget.statusBarHeight),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(12.w))),
              child: Text('底部'),
            ),
          )
        ],
      ),
    );
  }
}
