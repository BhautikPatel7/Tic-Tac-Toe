import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

// Create an instance of FlutterLocalNotificationsPlugin
// Global instance for the notifications plugin
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications(); // Initialize notifications on startup
  runApp(MyApp());
}

// Function to initialize local notifications
void initializeNotifications() {
  var initializationSettingsAndroid =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid);

  flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: MaterialApp(
        home: TimerScreen(),
      ),
    );
  }
}

// The main screen that shows the timer and button
class TimerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final timerProvider = Provider.of<TimerProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Timer with Notification")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Time Remaining: ${timerProvider.remainingSeconds} seconds",
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                timerProvider
                    .startTimer(); // Start the timer and show notification
              },
              child: Text("Start Timer"),
            ),
          ],
        ),
      ),
    );
  }
}

class TimerProvider with ChangeNotifier {
  int _remainingSeconds = 2000; // Total duration of the timer
  int _totalSeconds =
      2000; // Store the initial timer value for progress calculation
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  int get remainingSeconds => _remainingSeconds;

  void startTimer() {
    _remainingSeconds = 2000; // Reset the timer
    _totalSeconds = 2000; // Store the total duration
    _showNotification(0); // Show notification with progress bar
    _countdown();
  }

  void _countdown() {
    if (_remainingSeconds > 0) {
      Future.delayed(Duration(seconds: 1), () {
        _remainingSeconds--;
        notifyListeners(); // Update the UI
        _updateProgressNotification(); // Update notification with progress
        _countdown(); // Continue the countdown
      });
    } else {
      _completeNotification(); // Notify when timer finishes
    }
  }

  // Function to show the initial notification with a progress bar
  void _showNotification(int progress) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id', 'Timer',
      channelDescription: 'Timer Notification',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true, // Make notification ongoing
      showWhen: false,
      onlyAlertOnce: true, // Avoid multiple sound alerts
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Timer Started', // Notification title
      'Time remaining: $_remainingSeconds seconds', // Notification body
      notificationDetails,
    );
  }

  // Function to update the notification with progress
  void _updateProgressNotification() async {
    // Calculate the progress percentage (0 to 100)
    int progress = ((_totalSeconds - _remainingSeconds) * 100) ~/ _totalSeconds;

    var androidDetails = AndroidNotificationDetails(
      'channel_id', 'Timer',
      channelDescription: 'Timer Notification',
      importance: Importance.max,
      priority: Priority.high,
      ongoing: true,
      showWhen: false,
      onlyAlertOnce: true,
      progress: 100, // Set max progress value to 100
      indeterminate: false, // Make sure it's determinate
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    // Update the notification with progress
    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Timer Update',
      'Time remaining: $_remainingSeconds seconds',
      notificationDetails,
    );
  }

  // Function to show a notification when the timer finishes
  void _completeNotification() async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Timer Finished',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    var notificationDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Timer Done',
      'The timer has ended.',
      notificationDetails,
    );
  }
}
