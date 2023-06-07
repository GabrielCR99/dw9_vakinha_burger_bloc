import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../repositories/auth/auth_repository.dart';
import '../../repositories/auth/auth_repository_impl.dart';
import '../rest_client/custom_dio.dart';

class ApplicationBinding extends MultiProvider {
  final Widget child;

  ApplicationBinding({required this.child, super.key})
      : super(
          providers: [
            Provider(create: (_) => CustomDio()),
            RepositoryProvider<AuthRepository>(
              create: (context) => AuthRepositoryImpl(dio: context.read()),
            ),
          ],
          child: child,
        );
}
