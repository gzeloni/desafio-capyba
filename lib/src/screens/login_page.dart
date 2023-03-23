import 'package:desafio_capyba/src/models/welcome.dart';
import 'package:desafio_capyba/src/screens/home.dart';
import 'package:desafio_capyba/src/screens/new_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Dependências
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Duration duration = const Duration(seconds: 3);
  bool _showPassword = true;

  Future signIn() async {
    try {
      showDialog(
        context: context,
        builder: (context) {
          return const HomePage();
        },
      );
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      )
          .then((value) {
        Navigator.of(context).pop();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false);
      });
    } on FirebaseAuthException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showPassword() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 1, 14, 31),
      body: SafeArea(
        child: ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          shrinkWrap: true,
          reverse: true,
          padding:
              const EdgeInsets.only(top: 120, right: 20, left: 20, bottom: 20),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Welcome(
                  title: 'Seja bem-vindo!',
                ),
                const SizedBox(height: 50),
                //Email TextField
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 14, 31),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email',
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 1, 14, 31),
                      border: Border.all(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _passwordController,
                        obscureText: _showPassword,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              showPassword();
                            },
                            child: Icon(
                              _showPassword == true
                                  ? Iconsax.eye_slash
                                  : Iconsax.eye,
                              color: Colors.white,
                            ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Senha',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) {
                          //     return changePassword();
                          //   },
                          // );
                        },
                        child: const Text(
                          'Esqueci minha senha',
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                //LoginButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        signIn();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const AlertDialog(
                              backgroundColor:
                                  Color.fromARGB(255, 215, 254, 215),
                              title: Text(
                                "Algo deu errado!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 1, 14, 31),
                                ),
                              ),
                              content: Text(
                                "Tenha certeza de que preencheu os campos corretamente.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 1, 14, 31),
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 233, 99),
                        border: Border.all(
                            color: const Color.fromARGB(255, 1, 14, 31)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Entrar',
                          style: TextStyle(
                              color: Color.fromARGB(255, 1, 14, 31),
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NewUserPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Criar Conta',
                    style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
