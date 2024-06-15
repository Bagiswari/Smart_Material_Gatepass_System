import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  void initialize() {
    // Register for token updates
    _firebaseMessaging.getToken().then((String? token) {
      if (token != null) {
        print('Token: $token');
        // You can handle the token here, such as sending it to your server
      } else {
        print('Unable to retrieve token');
      }
    });

    // Listen for incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<void> sendNotification(String token, String title, String body) async {
    // Implement FCM sending logic here
  }
}
