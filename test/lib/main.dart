import 'package:flutter/material.dart';
import 'package:flutterbaseproject/repo/user_repo.dart';
import 'package:flutterbaseproject/service/api/api_service.dart';
import 'package:flutterbaseproject/service/db/db_service.dart';
import 'package:flutterbaseproject/service/language/language_service.dart';
import 'package:flutterbaseproject/service/shared_preference/shared_preference_service.dart';
import 'package:flutterbaseproject/ui/splash/splash_route.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// api init
  ApiService apiService = ApiService();

  /// database init
  DbService databaseService = DbService();

  /// shared preferences init
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedPreferenceService sharedPreferenceServices =
      SharedPreferenceService(sharedPreferences);
  return runApp(MyApp(
    databaseService: databaseService,
    apiService: apiService,
    sharedPreferenceServices: sharedPreferenceServices,
  ));
}

class MyApp extends StatelessWidget {
  final DbService databaseService;
  final ApiService apiService;
  final SharedPreferenceService sharedPreferenceServices;

  MyApp({
    required this.sharedPreferenceServices,
    required this.apiService,
    required this.databaseService,
  });

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
       ProxyProvider<SharedPreferenceService, LanguageService>(
         update: (context, sharedPreferenceService, languageService) =>
             LanguageService(sharedPreferenceService),
         dispose: (context, languageService) => languageService.dispose(),
       ),

        /// userRepo
        ProxyProvider3<DbService, ApiService, SharedPreferenceService,
            UserRepo>(
          update: (context, databaseService, apiService,
              sharedPreferenceService, userRepo) {
            if (userRepo != null) return userRepo;
            return UserRepo(
                databaseService: databaseService,
                apiService: apiService,
                sharedPreferenceService: sharedPreferenceService);
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: splashRoute,
      ),
    );
  }
}
