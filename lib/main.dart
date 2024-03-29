import 'package:finance_track_app/base/base_app.dart';
import 'package:finance_track_app/firebase_options.dart';
import 'package:finance_track_app/ui/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  NotificationService().initNotification();
  runApp(FinanaceTrackingApp());
}
