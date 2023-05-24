import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:kidnap_detection_app/core/navigation/module.dart';
import 'package:kidnap_detection_app/modules/test_flask/test_flask_screen.dart';
import 'package:provider/provider.dart';

import 'modules/camera_view/controller/kidnap_provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => KidnapResults()),
      ],
      child: ModularApp(
        module: AppModule(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Modular.setNavigatorKey(navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kidnap Detection App',
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return child ?? TestFlaskScreen();
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
