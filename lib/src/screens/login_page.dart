import 'package:desafio_capyba/src/functions/sign_in.dart';
import 'package:desafio_capyba/src/models/alert_dialogs/alert_dialog.dart';
import 'package:desafio_capyba/src/models/button/button.dart';
import 'package:desafio_capyba/src/models/text_fields/custom_text_field.dart';
import 'package:desafio_capyba/src/models/welcome_message/welcome.dart';
import 'package:desafio_capyba/src/screens/new_user.dart';
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
                CustomTextField(
                  enabled: true,
                  useController: true,
                  controller: _emailController,
                  hintText: 'Email',
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
                              setState(() {
                                showPassword();
                              });
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
                  height: 30,
                ),

                //LoginButton
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100),
                  child: GestureDetector(
                    onTap: () {
                      if (_emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty) {
                        SignIn(
                          context: context,
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        ).signIn();
                      } else {
                        const CustomAlertDialog(
                          title: "Algo deu errado!",
                          content:
                              "Tenha certeza de que preencheu os campos corretamente.",
                        );
                      }
                    },
                    child: const Cadastrar(
                      title: 'Entrar',
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
                        builder: (context) => const NewUserPage(),
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
