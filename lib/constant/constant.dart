import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sptk/constant/cupertino.dart';

part 'colors.dart';
part 'card_image.dart';
part 'toast.dart';

class Constant{
  static Widget title(String title){
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ),
      child: Text(title, 
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18
        ),
      ),
    );
  }
}