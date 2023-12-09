import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/pages/sign_in.dart';
import 'package:food_app/shared/colors.dart';
import 'package:food_app/shared/contants.dart';
import 'package:food_app/shared/snackbar.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  // Contrôleur pour le champ de texte de l'email.
  final emailController = TextEditingController();
  // Indicateur de chargement.
  bool isLoading = false;
  // Clé pour le formulaire.
  final _formKey = GlobalKey<FormState>();

  // Fonction pour réinitialiser le mot de passe.
  resetPassword() async {
    // Affiche une boîte de dialogue avec un indicateur de chargement.
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    );

    try {
      // Envoie un e-mail de réinitialisation du mot de passe à l'adresse spécifiée.
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text);
      // Affiche un message indiquant que l'opération est terminée.
      showSnackBar(context, "Fait - Veuillez vérifier votre e-mail");
    } on FirebaseAuthException catch (e) {
      // Affiche une erreur si la réinitialisation échoue.
      showSnackBar(context, "ERREUR : ${e.code}");
    }

    // Arrête l'indicateur de chargement.

    if (!mounted) return;

    // Redirige l'utilisateur vers l'écran de connexion.
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }

  @override
  void dispose() {
    // Libère les ressources du contrôleur d'email lorsqu'il n'est plus utilisé.
    emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barre d'applications avec un titre personnalisé et une couleur de fond.
      appBar: AppBar(
        title: const Text("Réinitialiser le mot de passe"),
        elevation: 0,
        backgroundColor: appbarGreen,
      ),
      // Corps de la page, centré et avec un remplissage.
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Texte d'instruction.
                const Text(
                  "Entrez votre e-mail pour réinitialiser votre mot de passe.",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(
                  height: 33,
                ),
                // Champ de texte pour l'e-mail.
                TextFormField(
                  validator: (email) {
                    // Validation de l'e-mail en utilisant une expression régulière.
                    return email!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Entrez un e-mail valide";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  decoration: decorationTextfield.copyWith(
                    hintText: "Entrez votre e-mail : ",
                    suffixIcon: const Icon(Icons.email),
                  ),
                ),
                const SizedBox(
                  height: 33,
                ),
                // Bouton pour réinitialiser le mot de passe.
                ElevatedButton(
                  onPressed: () async {
                    // Vérifie si le formulaire est valide avant de réinitialiser le mot de passe.
                    if (_formKey.currentState!.validate()) {
                      resetPassword();
                    } else {
                      // Affiche une erreur si le formulaire est invalide.
                      showSnackBar(context, "ERREUR");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(bTNgreen),
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Réinitialiser le mot de passe",
                          style: TextStyle(fontSize: 19),
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
