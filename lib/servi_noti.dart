import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class NotiService {
  final notificationsPlugin = FlutterLocalNotificationsPlugin();
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;
    /*if (Platform.isAndroid) {
      final status = await Permission.notification.request();
    if (!status.isGranted) return;
    }*/
    const initSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );
    
    await notificationsPlugin.initialize(initSettings);
    _isInitialized = true; 
  }

  NotificationDetails notificationDetails (){
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'Primax Bancos',
        importance: Importance.max,
        priority: Priority.high,
        color:null,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
  
  Future <void> showNotification({
    int id = 0,
    required String? title,
    required String? body,
  }) async{
    return notificationsPlugin.show(id,title,body,notificationDetails());
  }
  

}