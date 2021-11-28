import 'package:flutter/cupertino.dart';

class Layout {

  final BuildContext context;
  Layout({required this.context});
 
  double tileWidth() {
    var media = MediaQuery.of(context).size;
    if (media.width * .25 < 400) {
      return 400;
    } else {
      return media.width * .25;
    }
  }
  
  double customTileWidth(double? percent, double? min) {
    var media = MediaQuery.of(context).size;
    if (null != min && media.width * percent! < min) {
      return min;
    } else {
      return media.width * percent!;
    }
  }

  double tileHeight() {
    var media = MediaQuery.of(context).size;
    if (media.height * .25 < 400) {
      return 400;
    } else {
      return media.height * .25;
    }
  }

  double customTileHeight(double percent, double min) {
    var media = MediaQuery.of(context).size;
    if (media.height * percent < min) {
      return min;
    } else {
      return media.height * percent;
    }
  }
}