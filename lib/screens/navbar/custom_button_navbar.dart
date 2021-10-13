import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:sptk/constant/constant.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;
  const CustomBottomNavBar({Key? key, this.selectedIndex = 0, required this.onTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(0);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              child: Icon(FeatherIcons.info, color: selectedIndex == 0 ? ThemeColors.primary : ThemeColors.muted),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(1);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              margin: const EdgeInsets.symmetric(horizontal: 83),
              child: Icon(FeatherIcons.home, color: selectedIndex == 1 ? ThemeColors.primary : ThemeColors.muted),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(2);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              child: Icon(FeatherIcons.download, color: selectedIndex == 2 ? ThemeColors.primary : ThemeColors.muted,),
            ),
          )
        ],
      ),
    );
  }
}