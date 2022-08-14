import 'package:flutter/material.dart';
import '../../../config/app_text_style.dart';
import '../widget/common_elevated_button.dart';

commonAddDialog({
  required BuildContext context,
  required String title1,
  required Icon icon1,
  required VoidCallback onTap1,
  required String title2,
  required Icon icon2,
  required VoidCallback onTap2,
}) async {
  await showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(
              title1,
              style: AppTextStyle.fontSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: icon1,
            onTap: onTap1,
          ),
          ListTile(
            title: Text(
              title2,
              style: AppTextStyle.fontSize14.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: icon2,
            onTap: onTap2,
          ),
        ],
      ),
    ),
    barrierDismissible: true,
  );
}

showConfirmDialog(
  BuildContext context, {
  required String title,
  required String subTitle,
  required String textButton,
  VoidCallback? onPressed,
}) async {
  await showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: Text(subTitle, textAlign: TextAlign.center),
      actions: [
        Center(
          child: CommonElevatedButton(
            text: textButton,
            onPressed: onPressed ?? () => Navigator.pop(context),
          ),
        )
      ],
    ),
  );
}
