import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../widgets/common_method.dart';
import '../color_res.dart';
import '../preferences.dart';

class PushNotificationsManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  bool _permissionRequested = false;

  Future<void> init(BuildContext context) async {
    // Initialize notification settings
    await _initializeNotifications();

    // Request notification permissions only if it hasn't been requested already
    if (!_permissionRequested) {
      await _requestNotificationPermissions();
      _permissionRequested = true;
    }

    // Configure foreground notification options
    await _configureForegroundNotifications();

    // Handle background notifications (register background handler)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Listen to foreground notifications
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (kDebugMode) {
        print("Foreground message: ${message.notification?.title}");
      }

      if (message.notification != null) {
        final notificationTitle = message.notification?.title ?? '';
        final notificationBody = message.notification?.body ?? '';

        // Handle foreground notification
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleNotification(
            context,
            title: notificationTitle,
            body: notificationBody,
          );
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if (kDebugMode) {
        print("Notification clicked: ${message.data}");
      }
    });

    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // Handle notification that was tapped to launch the app
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleNotification(
          context,
          title: initialMessage.notification?.title ?? '',
          body: initialMessage.notification?.body ?? '',
        );
      });
    }

    // Save device token after permission request
    await _saveDeviceToken();

  }
  // Save the device token in local storage
  Future<void> _saveDeviceToken() async {
    if (Platform.isAndroid) {
       FirebaseMessaging.instance.getToken().then((value) {
        String? token = value;
        log('Android Device Token: $token');
        Preferences.setString(Preferences.deviceToken, '$token');
      });
    } else if (Platform.isIOS) {
      FirebaseMessaging.instance.getToken().then((value) {
          String? token = value;
          log('iOS Device Token: $token');
          Preferences.setString(Preferences.deviceToken,'$token');
        });
    }
  }

  // Initialize local notifications
  Future<void> _initializeNotifications() async {
    var initializationSettingsAndroid = const AndroidInitializationSettings(
      '@drawable/ic_launcher',
    );
    var initializationSettingsIOS = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

   // await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (kDebugMode) {
          print("Notification details =-> ${details.actionId}");
          print("Notification details =-> ${details.id}");
          print("Notification details =-> ${details.input}");
          print("Notification details =-> ${details.notificationResponseType}");
          print("Notification details =-> ${details.payload}");
        }

        // if (details.payload != null) {
        //   openFile(details.payload!);
        // }
      },
    );

    // Android notification channel (only needed for Android 8.0 and above)
    const androidChannel = AndroidNotificationChannel(
      'channel_id', // The id of the channel.
      'channel_name', // The name of the channel.
      description: 'Description of the channel.',
      importance: Importance.max,
    );
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }

  // Request notification permissions
  Future<void> _requestNotificationPermissions() async {
    final settings = await _firebaseMessaging.getNotificationSettings();

    // Only request permission if not already granted
    if (settings.authorizationStatus == AuthorizationStatus.notDetermined ||
        settings.authorizationStatus == AuthorizationStatus.denied

    ) {
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  // Configure foreground notifications
  Future<void> _configureForegroundNotifications() async {
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  // Handle incoming notifications (either in the foreground or after app launch)
  Future<void> _handleNotification(
      BuildContext context, {
        required String title,
        required String body,
      }) async {
    // Show the notification locally or perform other actions
    await showNotification(notificationTitle: title, notificationBody: body);

    // Example: You could update a provider or navigate to a screen
    // Provider.of<NotificationProvider>(context, listen: false).addNotification(title, body);
  }

  // Show notification via local notifications
  Future<void> showNotification({
    required String notificationTitle,
    required String notificationBody,  String? payload,
  }) async {
    var androidDetails = AndroidNotificationDetails(
        'channel_id',
        'channel_name',
        importance: Importance.high,
        playSound: true,
        icon: "@drawable/ic_launcher",
        enableVibration: true,
        // sound: const RawResourceAndroidNotificationSound('notification_sound'),
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker',
    );

    var iosDetails = const DarwinNotificationDetails();
    var platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    ///Show notification container -->
    await flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      notificationBody,
      platformDetails,
      payload: payload,
    );
  }
}

// Background message handler
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // No need to call Firebase.initializeApp() here if already initialized
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  var androidDetails = const AndroidNotificationDetails(
    'channel_id',
    'channel_name',
    importance: Importance.max,
    priority: Priority.high,
    icon: '@drawable/ic_launcher',
    playSound: true,
    color: ColorRes.primaryLight,
  );

  var platformDetails = NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    message.hashCode,
    message.data['title'] ?? '',
    message.data['body'] ?? '',
    platformDetails,
  );
}

