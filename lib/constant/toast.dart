part of 'constant.dart';

class Toast {
  static show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: ThemeColors.black.withOpacity(.5),
      textColor: ThemeColors.white
    );
  }
}
