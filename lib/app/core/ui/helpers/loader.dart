import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  var _isOpen = false;

  void showLoader() {
    if (!_isOpen) {
      _isOpen = true;

      showDialog(
        context: context,
        builder: (_) => LoadingAnimationWidget.threeArchedCircle(
          color: Colors.white,
          size: 60,
        ),
      );
    }
  }

  void hideLoader() {
    if (_isOpen) {
      _isOpen = false;
      Navigator.of(context).pop();
    }
  }
}
