import 'package:flutter/cupertino.dart';

extension SizeExtension on BuildContext {
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

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
