import 'package:flutter/cupertino.dart';

class ConstantCupertino {
  static Widget indicator() {
    return const Center(
      child: CupertinoActivityIndicator(
        radius: 12,
      ),
    );
  }
}
