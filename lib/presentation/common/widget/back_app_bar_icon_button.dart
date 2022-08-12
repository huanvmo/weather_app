import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackAppBarIconButton extends StatelessWidget {
  const BackAppBarIconButton({Key? key, this.onPressed}) : super(key: key);
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: const Icon(
          Icons.navigate_before,
          color: Colors.black,
        ),
        width: 48.w,
        height: 48.h,
      ),
      onPressed: onPressed ?? () => Navigator.of(context).pop(),
    );
  }
}
