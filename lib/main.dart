import 'package:flight_booking_app/screen/flight_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flight_booking_app/utils/no_internet_data_found.dart';
import 'package:flight_booking_app/utils/preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'data/remote/dio/InternetStatusManager.dart';
import 'diContainer.dart' as di;
import 'helpers/navHelper.dart';
import 'helpers/responsive_helper.dart';
import 'package:flight_booking_app/providers/flight_details_provider.dart';
import 'package:flight_booking_app/providers/flight_results_provider.dart';
import 'package:flight_booking_app/providers/flight_search_provider.dart';


Future<void> main() async {
  await _init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => di.sl<FlightSearchProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FlightResultsProvider>()),
        ChangeNotifierProvider(create: (_) => di.sl<FlightDetailsProvider>()),
      ],
      child: const MyApp(),
    ),
  );
}

_init() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await di.init();
  await dotenv.load(fileName: ".dev.env");
  // await dotenv.load(fileName: ".live.env");
  await Preferences.initPref();
 // await Upgrader.clearSavedSettings();
  // await FirebaseHelper.init();
  // Initialize Internet Monitoring
  InternetStatusManager().initialize();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>();

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ResponsiveHelper.updateSize(context);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark, // Android
        statusBarBrightness: Brightness.light,    // iOS
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Flight Booking',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        navigatorObservers: [routeObserver],

        builder: (context, child) {
          final mediaQuery = MediaQuery.of(context);
          return MediaQuery(
            data: mediaQuery.copyWith(
              textScaler: TextScaler.linear(
                mediaQuery.textScaler.scale(1.0).clamp(0.8, 1.2),
              ),
            ),
            child: child!,
          );
        },
        home: NoInternetDataFound(
          onRetry: () => debugPrint("App-level retry"),
          child: const FlightSearchScreen(),
        ),
      ),
    );
  }
}

