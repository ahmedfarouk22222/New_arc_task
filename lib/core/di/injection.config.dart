// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;

import '../network/api_client.dart' as _i557;
import '../routes/app_router.dart' as _i629;
import 'injectable_modules.dart' as _i129;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final injectableModules = _$InjectableModules();
    gh.lazySingleton<_i557.ApiClient>(() => _i557.ApiClient());
    gh.lazySingleton<_i629.AppRouter>(() => _i629.AppRouter());
    gh.lazySingleton<_i361.Dio>(
      () => injectableModules.dio(gh<_i557.ApiClient>()),
    );
    gh.lazySingleton<_i583.GoRouter>(
      () => injectableModules.goRouter(gh<_i629.AppRouter>()),
    );
    return this;
  }
}

class _$InjectableModules extends _i129.InjectableModules {}
