// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// Project imports:

import '../../../config/app_colors.dart';
import '../../../config/app_text_style.dart';
import '../../../generated/l10n.dart';

class LoadingDialog {
  static void hideLoadingDialog(context) {
    if (_dialogIsVisible(context)) {
      Navigator.of(context).pop();
    }
  }

  static bool _dialogIsVisible(BuildContext context) {
    bool isVisible = false;
    Navigator.popUntil(context, (route) {
      isVisible = route is PopupRoute;

      return !isVisible;
    });

    return isVisible;
  }

  static void showLoadingDialog(BuildContext context) {
    final alert = AlertDialog(
      content: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCubeGrid(
              color: AppColors.primaryColor,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              S.current.loading,
              style: AppTextStyle.fontSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
    if (!_dialogIsVisible(context)) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return alert;
        },
      );
    }
  }
}
