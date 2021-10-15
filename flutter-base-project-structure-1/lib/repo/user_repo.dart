import 'package:flutterbaseproject/service/api/api_service.dart';
import 'package:flutterbaseproject/service/db/db_service.dart';
import 'package:flutterbaseproject/service/shared_preference/shared_preference_service.dart';

class UserRepo {
  UserRepo({
    required this.databaseService,
    required this.apiService,
    required this.sharedPreferenceService,
  });

  final DbService databaseService;
  final ApiService apiService;
  final SharedPreferenceService sharedPreferenceService;
}
