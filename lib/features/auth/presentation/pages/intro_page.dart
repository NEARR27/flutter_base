import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/sign_in_page.dart';
import 'package:ui_one/features/auth/presentation/pages/sign_up_page.dart';

import '../components/buttons.dart';

class IntroPage extends StatefulWidget {
  static const String id = "intro_page";
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo de imagen
          Image.asset(
            "assets/images/Hanamaru.jpg",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bienvenido",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Inicia sesión para continuar!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(height: 40),
                  MyButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpPage.id);
                    },
                    text: "¡Crea una cuenta aquí!",
                    buttonColor: Colors.blue,
                    textColor: Colors.transparent,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "¿Ya tienes una cuenta?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Inicia Sesión!",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, SignInPage.id);
                        },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
