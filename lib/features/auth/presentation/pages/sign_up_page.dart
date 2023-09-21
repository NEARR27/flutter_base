import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/components/buttons.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import 'package:ui_one/service._locator.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "sign_up_page";

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _signUpGlobalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetryController = TextEditingController();
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
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _signUpGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),

                    // Botón de Icono de Volver
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.chevron_left,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        SizedBox(width: 10),
                        Text(
                          "Ingresa tus datos",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 55),
                    Column(
                      children: [
                        // Entrada de Nombre -------------------------------------
                        TextFormField(
                          controller: nameController,
                          validator: AuthValidator.isNameValid,
                          decoration: const InputDecoration(
                            hintText: "nombre de usuario",iconColor: Colors.black
                          ),
                        ),

                        // Entrada de Correo Electrónico -------------------------------------
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: emailController,
                          validator: AuthValidator.isEmailValid,
                          decoration: const InputDecoration(
                            hintText: "dirección de correo electrónico",
                          ),
                        ),

                        // Entrada de Contraseña -------------------------------------
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: passwordController,
                          obscureText: passwordSee,
                          validator: AuthValidator.isPasswordValid,
                          decoration: InputDecoration(
                            hintText: "contraseña",
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

                        // Entrada de Confirmación de Contraseña -------------------------------------
                        const SizedBox(height: 40),
                        TextFormField(
                          controller: passwordRetryController,
                          obscureText: passwordSee,
                          validator: AuthValidator.isPasswordValid,
                          decoration: const InputDecoration(
                            hintText: "confirmar contraseña",
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Botón "Continuar" ----------------------------------
                        MyButtonTwo(
                          text: "Continuar",
                          onPressed: signUpButton,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Cuando se presiona el botón
  void signUpButton() {
    if (_signUpGlobalKey.currentState!.validate()) {
      final message = authController.registration(
        nameController.text.trim(),
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
    }
  }

  // Los controladores de texto se eliminan cuando se finaliza
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetryController.dispose();
    super.dispose();
  }
}
