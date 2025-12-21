
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizing/sizing.dart';
import '../../Config/Constant/ColorsConstant.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => nextPage());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Full background
          Image.asset(
            'assets/image/splash_bg.png',
            fit: BoxFit.cover,
          ),

          // Content respects toolbar
          const SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  // your UI
                ],
              ),
            ),
          ),
        ],
      ),
    );

  }


  nextPage() async {
    // final data = await SecureStore().getStringData(SharedPrefKey.authorization)??"";
    // if (data.isEmpty) {
    //   RouteManagement().routeToOnboarding();
    // }else{
    //   final isBiometricEnable = await SecureStore().getBoolData(SharedPrefKey.isBiometricEnable) ?? false;
    //   if(isBiometricEnable==true) {
    //     RouteManagement().routeToBiometricVerificationView();
    //   }else {
    //     RouteManagement().routeToHomeView(isFromSplash: true);
    //   }
    // }
  }


  @override
  void dispose() {
    super.dispose();
  }
}
