import 'package:flutter/material.dart';
import 'package:services_provider_application/main.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    splashControl.loadDataAndNavigate();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/buyer/images/splash_bc.png"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(200)),
            child: Image.asset(
              'assets/buyer/images/logo.png',
              width: 250,
            ),
          ),
        ),
      ),
    );
  }
}
