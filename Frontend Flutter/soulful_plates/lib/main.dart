import 'package:flutter/material.dart';

import 'app.dart';
import 'utils/shared_prefs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();]
  await UserPreference.initSharedPrefs();
  runApp(const MyApp());
}
