import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../network/api_client.dart';
import '../network/auth_interceptor.dart';
import '../network/auth/auth_repository.dart';
import '../network/profile/profile_repository.dart';
import '../network/waste_event/waste_event_repository.dart';
import '../network/driver/driver_repository.dart';
import '../../presentation/bloc/auth/auth_bloc.dart';
import '../../presentation/bloc/profile/profile_bloc.dart';
import '../../presentation/bloc/waste_event/waste_event_bloc.dart';
import '../../presentation/bloc/driver/driver_task_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // Core
  sl.registerLazySingleton(() => AuthInterceptor(sl()));
  sl.registerLazySingleton<Dio>(() => ApiClient(authInterceptor: sl()).dio);

  // Features - Authentication
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(dio: sl(), sharedPreferences: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

  // Features - Profile
  sl.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(dio: sl()));
  sl.registerFactory(() => ProfileBloc(profileRepository: sl(), authRepository: sl()));

  // Features - Waste Event
  sl.registerLazySingleton<WasteEventRepository>(() => WasteEventRepositoryImpl(dio: sl()));
  sl.registerFactory(() => WasteEventBloc(repository: sl()));

  // Features - Driver Task
  sl.registerLazySingleton<DriverRepository>(() => DriverRepositoryImpl(dio: sl()));
  sl.registerFactory(() => DriverTaskBloc(repository: sl()));
}
