import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier {
  final googleSignIn =
      GoogleSignIn(); // Instance de la classe GoogleSignIn pour gérer la connexion Google
  GoogleSignInAccount? _user; // Compte Google actuellement connecté
  GoogleSignInAccount get user =>
      _user!; // Getter pour récupérer le compte Google actuel

  // Fonction pour effectuer la connexion avec Google
  googlelogin() async {
    final googleUser = await googleSignIn
        .signIn(); // Ouvre l'écran de connexion Google et récupère les informations de l'utilisateur
    // ignore: unnecessary_null_comparison
    if (googleSignIn == null)
      return; // Si l'utilisateur annule la connexion, retourne sans effectuer d'action
    _user =
        googleUser; // Met à jour le compte Google actuel avec l'utilisateur connecté
    final googleAuth = await googleUser
        ?.authentication; // Récupère les informations d'authentification Google de l'utilisateur
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, // Récupère le jeton d'accès Google
      idToken: googleAuth?.idToken, // Récupère le jeton d'identification Google
    );
    await FirebaseAuth.instance.signInWithCredential(
        credential); // Connecte l'utilisateur avec les informations d'authentification Google
    notifyListeners(); // Notifie les auditeurs du changement d'état pour mettre à jour l'interface utilisateur
  }
}
