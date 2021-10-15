import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'dependencies/app_dependencies.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppDependencies.init();
  runApp(App());
}
