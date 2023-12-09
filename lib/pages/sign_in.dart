import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/pages/forgot_passowrd.dart';
import 'package:food_app/pages/register.dart';
import 'package:food_app/provider/google_signin.dart';

import 'package:food_app/shared/colors.dart';
import 'package:food_app/shared/contants.dart';
import 'package:food_app/shared/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isVisable =
      false; // Un indicateur pour montrer ou cacher le mot de passe
  final emailController =
      TextEditingController(); // Contrôleur pour le champ de l'email
  final passwordController =
      TextEditingController(); // Contrôleur pour le champ du mot de passe
  bool isLoading =
      false; // Indicateur d'état pour montrer si une opération est en cours

  // Fonction pour la connexion avec email et mot de passe
  signIn() async {
    setState(() {
      isLoading =
          true; // Active l'indicateur de chargement pendant la connexion
    });

    try {
      // Utilise FirebaseAuth pour la connexion avec les informations fournies
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      // Gère les exceptions FirebaseAuth et affiche un message d'erreur
      showSnackBar(context, "ERROR :  ${e.code} ");
    }

    setState(() {
      isLoading =
          false; // Désactive l'indicateur de chargement après la connexion
    });
  }

  @override
  void dispose() {
    // Libère les ressources des contrôleurs à la fin de la vie du widget
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarGreen,
        title: const Text("Sign in",style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 230,
                  height: 80,
                  alignment: Alignment.center,
                  child: Image.asset(
                    "assets/menus/logo.png",
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                // Champ de saisie pour l'email
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Email : ",
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                // Champ de saisie pour le mot de passe
                TextField(
                  controller: passwordController,
                  keyboardType: TextInputType.text,
                  obscureText: isVisable ? false : true,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Enter Your Password : ",
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isVisable = !isVisable;
                        });
                      },
                      icon: isVisable
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                // Bouton pour lancer le processus de connexion
                ElevatedButton(
                  onPressed: () async {
                    await signIn(); // Appelle la fonction signIn définie ci-dessus
                    if (!mounted) return;
                    // showSnackBar(context, "Done ... ");
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNgreen),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    )),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 19),
                        ),
                ),
                const SizedBox(
                  height: 9,
                ),
                // Bouton pour naviguer vers la page de récupération de mot de passe
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()),
                    );
                  },
                  child: const Text(
                    "Forgot password?",
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                // Lien pour naviguer vers la page d'inscription
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Do not have an account?",
                        style: TextStyle(fontSize: 18)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Register()),
                        );
                      },
                      child: const Text(
                        'sign up',
                        style: TextStyle(
                            fontSize: 18, decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 17,
                ),
                const SizedBox(
                  width: 299,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                        ),
                      ),
                      Text(
                        "OR",
                        style: TextStyle(),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                        ),
                      ),
                    ],
                  ),
                ),
                // Bouton pour la connexion avec Google
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 27),
                  child: GestureDetector(
                    onTap: () {
                      googleSignInProvider.googlelogin();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Color.fromARGB(255, 175, 103, 109),
                          width: 1,
                        ),
                      ),
                      child: SvgPicture.asset(
                        "assets/icons/google.svg",
                        color: const Color.fromARGB(255, 200, 67, 79),
                        height: 27,
                      ),
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
}
