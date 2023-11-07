import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/components/buttons.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import 'package:ui_one/service._locator.dart';

class SignUpPage extends StatefulWidget {
  static const String id = "sign_up_page";

  const SignUpPage({Key? key}) : super(key: key);

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
  bool passwordSee2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Establece el fondo transparente para que la imagen de fondo sea visible
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://www.blogdelfotografo.com/wp-content/uploads/2021/12/Fondo_Negro_3.webp"), // Reemplaza con la URL de tu imagen de fondo
            fit: BoxFit.cover, // Ajusta la imagen al tamaño del contenedor
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            child: Form(
              key: _signUpGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.chevron_left,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [
                          Colors.grey,
                          Colors.white,
                        ],
                      ).createShader(bounds);
                    },
                    child: const Row(
                      children: [
                        SizedBox(width: 10),
                        Text(
                          "Crear Cuenta",
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        validator: AuthValidator.isEmailValid,
                        decoration: InputDecoration(
                          hintText: "Email address",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: nameController,
                        validator: AuthValidator.isNameValid,
                        decoration: InputDecoration(
                          hintText: "User name",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: passwordController,
                        obscureText: passwordSee,
                        validator: AuthValidator.isPasswordValid,
                        decoration: InputDecoration(
                          hintText: "Create password",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordSee = !passwordSee;
                              setState(() {});
                            },
                            child: Icon(
                              passwordSee
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: passwordRetryController,
                        obscureText: passwordSee2,
                        validator: AuthValidator.isPasswordValid,
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              passwordSee2 = !passwordSee2;
                              setState(() {});
                            },
                            child: Icon(
                              passwordSee2
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 30),
                      MyButtonTwo(
                        text: "Crear",
                        onPressed: signUpButton,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> signUpButton() async {
    if (_signUpGlobalKey.currentState!.validate()) {
      try {
        final Map<String, String> message = await authController.registration(
          nameController.text.trim(),
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message["message"]!),
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .9),
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 5),
            shape: const StadiumBorder(),
            dismissDirection: DismissDirection.horizontal,
            showCloseIcon: true,
          ),
        );
      } catch (e) {
        print("Error: ${e.toString()}");
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordRetryController.dispose();
    super.dispose();
  }
}
