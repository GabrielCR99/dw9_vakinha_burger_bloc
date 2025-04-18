import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

base mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.error(message: message, backgroundColor: Colors.red),
  );

  void showInfo(String message) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.info(message: message, backgroundColor: Colors.blue),
  );

  void showSuccess(String message) => showTopSnackBar(
    Overlay.of(context),
    CustomSnackBar.success(message: message, backgroundColor: Colors.green),
  );
}

extension MessagesExt on BuildContext {
  void showError(String message) => showTopSnackBar(
    Overlay.of(this),
    CustomSnackBar.error(message: message, backgroundColor: Colors.red),
  );

  void showInfo(String message) => showTopSnackBar(
    Overlay.of(this),
    CustomSnackBar.info(message: message, backgroundColor: Colors.blue),
  );

  void showSuccess(String message) => showTopSnackBar(
    Overlay.of(this),
    CustomSnackBar.success(message: message, backgroundColor: Colors.green),
  );
}
