import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeNotifications();
  runApp(MyApp());
}
//Creating an instance of the FlutterLocalNotificationsPlugin class.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    
//initializing notification
Future<void> initializeNotifications() async {
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings settings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(settings);
}


//show notification function
Future<void> showNotification(String title, String content) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'channel_id',
    'Channel Name',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails details =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    content,
    details,
  );
}
//clear
void clear(){
  titleControler.clear();
  contentControler.clear();
}
//
TextEditingController titleControler=TextEditingController();
TextEditingController contentControler=TextEditingController();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Local Notification')),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: titleControler,
                decoration: InputDecoration(
                  hintText: 'title'
                ),
              ),
            ),
            Container(
               margin: EdgeInsets.all(10),
              child: TextField(
                controller: contentControler,
                decoration: InputDecoration(
                  hintText: 'content'
                ),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed:(){
                   showNotification(titleControler.text,contentControler.text);
                   clear();
                },
                child: Text('Show Notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
