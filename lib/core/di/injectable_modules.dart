import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

import '../network/api_client.dart';
import '../routes/app_router.dart';

@module
abstract class InjectableModules {
  @lazySingleton
  Dio dio(ApiClient apiClient) => apiClient.createDio();

  @lazySingleton
  GoRouter goRouter(AppRouter appRouter) => appRouter.router;
}
