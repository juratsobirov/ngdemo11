import 'package:hive/hive.dart';
import 'package:ngdemo11/service/sql_service.dart';
import 'package:path_provider/path_provider.dart';

import '../model/member_model.dart';
import 'hive_service.dart';

class RootService {
  static Future<void> init() async {

    await HiveService.init();
    await SqlService.init();

  }
}
