import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'loading_screen_controller.dart';

class LoadingScreen {
  LoadingScreenController? _controller;
  static LoadingScreen? _instance;

  LoadingScreen._();

  static LoadingScreen get instance {
    _instance ??= LoadingScreen._();

    return _instance!;
  }

  void show(BuildContext context) {
    if (_controller != null) {
      return;
    }
    _controller = _showOverlay(context);
  }

  void hide() {
    _controller?.onCloseLoading();
    _controller = null;
  }

  LoadingScreenController? _showOverlay(BuildContext context) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (_) => WillPopScope(
        onWillPop: () async => false,
        child: Material(
          color: Colors.black.withAlpha(150),
          child: LoadingAnimationWidget.threeArchedCircle(
            color: Colors.white,
            size: 60,
          ),
        ),
      ),
    );

    state.insert(overlay);

    return LoadingScreenController(
      onCloseLoading: () {
        overlay.remove();

        return true;
      },
    );
  }
}

extension LoaderMixin on BuildContext {
  void showLoader() => LoadingScreen.instance.show(this);

  void hideLoader() => LoadingScreen.instance.hide();
}
