import 'dart:async';
import 'package:flutter/material.dart';
import '../views/signinpage.dart'; // Assurez-vous de créer cette page plus tard

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Préchargez l'image ici car les widgets hérités comme MediaQuery sont disponibles
    precacheImage(AssetImage('assets/images/splash_image.jpg'), context)
        .then((_) {
      // Démarre un Timer pour rediriger vers la page de connexion après 1 seconde
      Timer(Duration(seconds: 1), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => SignInPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
            'assets/images/splash_image.jpg'), // Assurez-vous que l'image est dans le dossier assets
      ),
    );
  }
}
