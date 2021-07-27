import 'dart:async';

import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  StreamSubscription? _subLanguageChange;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _subLanguageChange?.cancel();
    super.dispose();
  }

  /// close screen with [result]
  void finish({dynamic result}) {
    return Navigator.of(context).pop(result);
  }
}
