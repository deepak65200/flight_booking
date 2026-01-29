import 'dart:io';
import 'package:firebase_core/firebase_core.dart';


class FirebaseHelper {
  static String get firebaseApiKey =>
      Platform.isAndroid
          ? 'AIzaSyA7rypBfk5AJtQ11zvELBJ736avAObZvRU' // Android key
          : 'AIzaSyBFJNLB1qLI6LPDsY9ew_KHKIYmDSQsocM'; // iOS key

  static String get firebaseAppId =>
      Platform.isAndroid
          ? '1:919774712207:android:9abec46ea2a42d698c3bfa'
          : '1:919774712207:ios:726503bef94bc8008c3bfa';

  static const String messagingSenderId = '919774712207';

  static const String projectId = 'guesthouse-d8dd0';

  static const String storageBucket = 'guesthouse-d8dd0.firebasestorage.app';

  static Future<void> init() async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: firebaseApiKey,
        appId: firebaseAppId,
        messagingSenderId: messagingSenderId,
        projectId: projectId,
        // Optional for iOS
       //  databaseURL: 'https://$projectId.firebaseio.com',
       //  storageBucket: '$projectId.appspot.com',
        storageBucket: storageBucket,
      ),
    );
  }
}

