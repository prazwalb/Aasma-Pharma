import 'package:android_std/utils/constants/sizes.dart';
import 'package:android_std/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PAppbar extends StatelessWidget implements PreferredSize {
  const PAppbar({super.key, this.title,   this.showBackArrow = true, this.leadingIcon, required this.actions, this.leadingOnPressed});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback?  leadingOnPressed; 

  @override
  Widget build(BuildContext context) {
    return  Padding(padding: EdgeInsets.symmetric(horizontal: PSizes.md),
    child: AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow 
      ? IconButton(onPressed: () => Get.back(), icon: Icon(Icons.arrow_back_ios) )
      :leadingIcon!=null ? IconButton(onPressed: () => leadingOnPressed, icon: Icon(leadingIcon)):null,
      title: title,
      actions: actions,
      

    ));
  }
  
  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
  
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(PDeviceUtils.getAppBarHeight());
}