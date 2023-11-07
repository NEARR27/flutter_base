import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/admin_page.dart';
import 'package:ui_one/features/auth/presentation/pages/main_home.dart';
import 'package:ui_one/features/auth/presentation/pages/sign_up_page.dart';
import 'package:ui_one/features/auth/presentation/validator/auth_validator.dart';
import '../../../../service/auth_service.dart';



class SignInPage extends StatefulWidget {
  static const String id = "sign_in_page";

  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _signInGlobalKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool passwordSee = true;

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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.blue, Colors.white70],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "Iniciar sesión",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Colors.blueAccent, Colors.white],
                    ).createShader(bounds);
                  },
                  child: Text(
                    "¡Bienvenido!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Form(
                  key: _signInGlobalKey,
                  child: Column(
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ).createShader(bounds);
                        },
                        child: TextFormField(
                          controller: usernameController,
                          validator: AuthValidator.isNameValid,
                          decoration: InputDecoration(
                            hintText: "Nombre de usuario",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return LinearGradient(
                            colors: [Colors.grey, Colors.white],
                          ).createShader(bounds);
                        },
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: passwordSee,
                          validator: AuthValidator.isPasswordValid,
                          decoration: InputDecoration(
                            hintText: "Contraseña",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  onPressed: signIn,
                  child: Text(
                    "Ingresar",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 125, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "¿No tienes una cuenta?",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, SignUpPage.id);
                  },
                  child: Text(
                    "Registrarse",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() async {
    if (_signInGlobalKey.currentState!.validate()) {
      final authService = AuthService();

      final token = await authService.login(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      if (token != null) {
        // La autenticación fue exitosa, aquí puedes navegar a la página principal
        Navigator.pushNamed(context, MyApp.id);
      } else {
        // La autenticación falló, muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Inicio de sesión fallido"),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}