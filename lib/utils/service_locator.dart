import 'package:flutter_template/data/repository.dart';
import 'package:flutter_template/data/services/api_request.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton<Repository>(() => Repository(ApiRequest()));
}
