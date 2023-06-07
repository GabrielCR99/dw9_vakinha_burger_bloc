import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helpers/loader.dart';
import '../helpers/messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase<Object>>
    extends State<T> with Loader<T>, Messages<T> {
  late final C controller;

  @override
  void initState() {
    super.initState();
    controller = context.read<C>();
    scheduleMicrotask(onReady);
  }

  void onReady() {
    return;
  }
}
