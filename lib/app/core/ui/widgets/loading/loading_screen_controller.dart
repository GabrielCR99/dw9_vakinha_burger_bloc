import 'package:flutter/foundation.dart' show immutable;

typedef CloseLoadingScreen = bool Function();

@immutable
class LoadingScreenController {
  final CloseLoadingScreen onCloseLoading;

  const LoadingScreenController({required this.onCloseLoading});
}
