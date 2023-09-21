import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/admin_page.dart';
import 'package:ui_one/features/auth/presentation/pages/main_home.dart';
import 'package:ui_one/features/auth/presentation/pages/app_widget.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import 'package:ui_one/service._locator.dart';

import '../components/buttons.dart';

class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";

  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordSee = true;

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
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    width: 100,
                    height: 10,
                  ),
                  const Center(
                    child: Text(
                      "Bienvenido!\n Inicia Sesión con tu cuenta!!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 100,
                    height: 10,
                  ),
                  Column(
                    children: const [
                      SizedBox(height: 20),
                    ],
                  ),
                  Form(
                    key: _signInGlobalKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: emailController,
                          validator: AuthValidator.isEmailValid,
                          decoration:
                              const InputDecoration(hintText: "Correo electronico"),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordSee,
                          validator: AuthValidator.isPasswordValid,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                passwordSee = !passwordSee;
                                setState(() {});
                              },
                              child: Icon(
                                passwordSee
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 100),
                  Column(
                    children: [
                      MyButtonTwo(text: "Iniciar Sesión!", onPressed: signIn),
                      const SizedBox(height: 30),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void signIn() {
    if (_signInGlobalKey.currentState!.validate()) {
      final message = authController.login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message["message"] as String),
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * .9),
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 5),
          shape: const StadiumBorder(),
          dismissDirection: DismissDirection.horizontal,
          showCloseIcon: true,
        ),
      );
      if (message["next"] == "next") {
        AppWidget.isLogin = true;
        AppWidget.loggedUser["email"] = emailController.text.trim();
        AppWidget.loggedUser["password"] = passwordController.text.trim();
        //Navigator.pushNamed(context, AdminPage.id);
        Navigator.pushNamed(context, MyApp.id);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
