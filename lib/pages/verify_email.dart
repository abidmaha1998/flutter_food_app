import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/pages/home.dart';
import 'package:food_app/shared/colors.dart';
import 'package:food_app/shared/snackbar.dart';
import 'package:flutter/material.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false; // Indicateur de vérification de l'email
  bool canResendEmail =
      false; // Indicateur indiquant si l'email peut être renvoyé
  Timer? timer; // Objet Timer pour la gestion du temps

  @override
  void initState() {
    super.initState();
    // Vérifie si l'email de l'utilisateur actuel est vérifié
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    // Si l'email n'est pas vérifié, envoie un email de vérification et configure un timer pour vérifier périodiquement
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        // Recharge l'utilisateur actuel pour obtenir les dernières informations
        await FirebaseAuth.instance.currentUser!.reload();

        // Met à jour l'indicateur de vérification de l'email
        setState(() {
          isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        });

        // Arrête le timer si l'email est vérifié
        if (isEmailVerified) {
          timer.cancel();
        }
      });
    }
  }

  // Fonction pour envoyer l'email de vérification
  sendVerificationEmail() async {
    try {
      // Désactive le bouton de renvoi de l'email temporairement
      setState(() {
        canResendEmail = false;
      });

      // Attend pendant 5 secondes simulées pour simuler l'envoi de l'email
      await Future.delayed(const Duration(seconds: 5));

      // Active à nouveau le bouton de renvoi de l'email
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      // Affiche une snackbar en cas d'erreur
      showSnackBar(context, "ERROR => ${e.toString()}");
    }
  }

  @override
  void dispose() {
    // Annule le timer lors de la destruction du widget pour éviter les fuites de mémoire
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? Home() // Redirige vers la page d'accueil si l'email est vérifié
        : Scaffold(
            appBar: AppBar(
              title: const Text("Verify Email"),
              elevation: 0,
              backgroundColor: appbarGreen,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "A verification email has been sent to your email",
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Renvoie l'email de vérification si le bouton peut être cliqué
                      canResendEmail ? sendVerificationEmail() : null;
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(bTNgreen),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(12)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                    ),
                    child: const Text(
                      "Resend Email",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  TextButton(
                    onPressed: () {
                      // Déconnecte l'utilisateur actuel en cas d'annulation
                      FirebaseAuth.instance.signOut();
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
