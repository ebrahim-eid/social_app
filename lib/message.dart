import 'package:firebase_messaging/firebase_messaging.dart';

import 'components/widgets.dart';

class FCMessaging {
  final _firebaseMessaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCm = await _firebaseMessaging.getToken();
    print('token ==========$fCm');
  }

  void onMessage() {
    FirebaseMessaging.onMessage.listen((event) {
      showToast(message: 'on onMessage message', state: ToastStates.success);
      print(event.data.toString());
    });
  }

  void onMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      showToast(
          message: 'on onMessageOpenedApp message', state: ToastStates.success);
      print(event.data.toString());
    });
  }


}
