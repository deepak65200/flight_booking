import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flight_booking_app/providers/flight_details_provider.dart';
import 'package:flight_booking_app/providers/flight_results_provider.dart';
import 'package:flight_booking_app/providers/flight_search_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/remote/dio/connectivityInterceptor.dart';
import 'data/remote/dio/dioClient.dart';
import 'data/remote/dio/loggingInterceptor.dart';
import 'data/repo/flight_repo.dart';


final sl = GetIt.instance;
Connectivity connectivity = Connectivity();

Future<void> init() async {
  // Core
  sl.registerLazySingleton(
    () => DioClient(
      dotenv.env['BASE_URL'] ?? '',
      sl(),
      loggingInterceptor: sl(),
      sharedPreferences: sl(),
      connectivityInterceptor: sl(),
    ),
  );
  // Flight
  sl.registerLazySingleton(
        () => FlightRepo(
          sharedPreferences: sl(),
          dioClient: sl(),
    ),
  );
  // Flight
  sl.registerFactory(
        () => FlightSearchProvider(flightRepo: sl()),
  );

  sl.registerFactory(
        () => FlightResultsProvider(flightRepo: sl()),
  );

  sl.registerFactory(
        () => FlightDetailsProvider(flightRepo: sl()),
  );
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(
    () => ConnectivityInterceptor(connectivity: connectivity),
  );
}
