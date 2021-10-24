import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'network_data_source_impl.dart';

Future<void> setFirebaseNotification() async {
  var token = await FirebaseMessaging.instance.getToken();
  await saveTokenToDatabase(token ?? '');
  FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);

  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
          FlutterLocalNotificationsPlugin();

      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        '1',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              //icon: android.smallIcon,
            ),
          ),
        );
      }
    },
  );
}

saveTokenToDatabase(String token) async {
  var url = Uri.parse('http://10.0.2.2:3000/auth/token');
  await http.put(url, body: token, headers: await postAuthHeaders());
}
