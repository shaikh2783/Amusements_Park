import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:sizing/sizing.dart';
import 'Screens/Splash/SplashView.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Full screen layout but keep status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark, // Android
      statusBarBrightness: Brightness.light, // iOS
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: SizingBuilder(
        systemFontScale: false,
        builder: () {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: ThemeData(
              fontFamily: 'inter',
              appBarTheme: const AppBarTheme(
                backgroundColor: ColorsConstant.colorPrimary,
                elevation: 0,
              ),
            ),
            home: const SplashView(),
          );
        },
      ),
    );
  }
}
