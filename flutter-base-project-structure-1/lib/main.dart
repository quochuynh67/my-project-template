import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:flutterbaseproject/service/api/api_service.dart';
import 'package:flutterbaseproject/service/db/db_service.dart';
import 'package:flutterbaseproject/service/shared_preference/shared_preference_service.dart';
import 'package:flutterbaseproject/ui/splash/splash_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/theme/theme_notifier.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// api init
  final ApiService apiService = ApiService();

  /// database init
  final DbService databaseService = DbService();

  /// shared preferences init
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final SharedPreferenceService sharedPreferenceServices =
      SharedPreferenceService(sharedPreferences);

  SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values).then((_) {
    SharedPreferences.getInstance().then((prefs) {
      final darkModeOn =
          prefs.getBool('isDarkTheme') ?? ThemeNotifier.getSystemTheme();
      runApp(
        ChangeNotifierProvider<ThemeNotifier>(
          create: (_) =>
              ThemeNotifier(darkModeOn ? ThemeData.dark() : ThemeData.light()),
          child: MyApp(
            databaseService: databaseService,
            apiService: apiService,
            sharedPreferenceServices: sharedPreferenceServices,
          ),
        ),
      );
    });
  });
  // return runApp(MyApp(
  //   databaseService: databaseService,
  //   apiService: apiService,
  //   sharedPreferenceServices: sharedPreferenceServices,
  // ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.sharedPreferenceServices,
    required this.apiService,
    required this.databaseService,
  }) : super(key: key);

  /// Database
  final DbService databaseService;

  /// API service
  final ApiService apiService;

  /// Cache service using Share Preferences
  final SharedPreferenceService sharedPreferenceServices;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<DbService>.value(
          value: databaseService,
        ),
        Provider<ApiService>.value(
          value: apiService,
        ),
        Provider<SharedPreferenceService>.value(
          value: sharedPreferenceServices,
        ),

        /// multiple language
        // ProxyProvider<SharedPreferenceService, LanguageService>(
        //   update: (context, sharedPreferenceService, languageService) =>
        //       LanguageService(sharedPreferenceService),
        //   dispose: (context, languageService) => languageService.dispose(),
        // ),

        /// userRepo
        ProxyProvider3<DbService, ApiService, SharedPreferenceService,
            UserRepo>(
          update: (context, databaseService, apiService,
              sharedPreferenceService, userRepo) {
            if (userRepo != null) {
              return userRepo;
            }
            return UserRepo(
                databaseService: databaseService,
                apiService: apiService,
                sharedPreferenceService: sharedPreferenceService);
          },
        ),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, appState, child) {
          final themeNotifier = Provider.of<ThemeNotifier>(context);
          return MaterialApp(
            theme: themeNotifier.getTheme(),
            debugShowCheckedModeBanner: false,
            home: splashRoute,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
          );
        },
      ),
    );
  }
}
