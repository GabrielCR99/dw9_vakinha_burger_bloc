import 'package:flutter/cupertino.dart';

extension SizeExtension on BuildContext {
  double get width => MediaQuery.sizeOf(this).width;
  double get height => MediaQuery.sizeOf(this).height;

  double percentWidth(double percent) {
    assert(
      percent >= 0.0 && percent <= 1,
      'Percent must be between 0.0 and 1.0',
    );

    return width * percent;
  }

  double percentHeight(double percent) {
    assert(
      percent >= 0.0 && percent <= 1,
      'Percent must be between 0.0 and 1.0',
    );

    return height * percent;
  }
}
