import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:soulful_plates/routing/route_names.dart';
import 'package:soulful_plates/routing/router.dart';

import 'constants/app_theme.dart';
import 'constants/language/language_constants.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey(debugLabel: "MaterialKey");

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      navigatorKey: navigationKey,
      initialRoute: splashViewRoute,
      onGenerateRoute: generateRoute,
      title: LanguageConst.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.baseTheme,
    );
  }

  void localLogWriter(String text, {bool isError = false}) {
    Future.microtask(() => debugPrint('** $text ** isError: [$isError]'));
  }
}
