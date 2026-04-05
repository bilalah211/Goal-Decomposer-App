import 'package:flutter/cupertino.dart';

class MediaQueryHelper {
  static width(BuildContext context) => MediaQuery.of(context).size.width;

  static height(BuildContext context) => MediaQuery.of(context).size.height;
}
