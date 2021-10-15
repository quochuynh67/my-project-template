import 'package:flutter/material.dart';
import 'package:flutterbaseproject/core/theme/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'base_bloc.dart';

/// base state class with bloc
abstract class BaseStateBloc<T extends StatefulWidget, B extends BaseBloc>
    extends State<T> {
  /// get Bloc
  /// if call this method in [initState] set [listen] = false
  B getBloc({bool listen = false}) => Provider.of<B>(context, listen: listen);

  void setTheme(ThemeData theme) {
    Provider.of<ThemeNotifier>(context, listen: false).setTheme(theme);
  }
}
