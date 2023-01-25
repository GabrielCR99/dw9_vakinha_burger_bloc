import 'package:flutter_dotenv/flutter_dotenv.dart';

class Env {
  const Env._();

  static Env? _instance;

  static Env get i {
    _instance ??= const Env._();

    return _instance!;
  }

  Future<void> load() => dotenv.load();

  String? operator [](String key) => dotenv.env[key];
}
