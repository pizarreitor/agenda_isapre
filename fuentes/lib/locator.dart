import 'package:agenda_isapre/repository/task_repo.dart';
import 'package:get_it/get_it.dart';

import 'data/network/api.dart';

final sl = GetIt.instance;

Future<void> setupLocator()async{
  sl.registerLazySingleton<Api>(() => Api());
  sl.registerLazySingleton<TaskRepoImpl>(() => TaskRepoImpl());
}