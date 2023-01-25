import 'package:flutter/cupertino.dart';

import 'app/core/config/env/env.dart';
import 'app/dw_delivery_app.dart';

Future<void> main() async {
  await Env.i.load();
  runApp(DwDeliveryApp());
}
