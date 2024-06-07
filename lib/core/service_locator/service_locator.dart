import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_list_app/core/service_locator/service_locator.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.initGetIt();
