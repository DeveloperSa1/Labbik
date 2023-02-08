import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:labbaik/shared/constant/colors.dart';

class TaskezBottomSheet {
  // static const MethodChannel _channel = MethodChannel('taskezBottomSheet');
}

// showSettingsBottomSheet() => showAppBottomSheet(ProjectDetailBottomSheet());

showAppBottomSheet(Widget widget,
    {bool isScrollControlled = true,
    bool popAndShow = false,
    double? height}) {
  if (popAndShow) Get.back();
  return Get.bottomSheet(
      height == null ? widget : Container(height: height, child: widget),
      backgroundColor: white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      isScrollControlled: true);
}
