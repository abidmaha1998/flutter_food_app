// Importation des packages nécessaires pour le développement de l'application
import 'package:food_app/pages/home.dart';
import 'package:food_app/pages/sign_in.dart';

import 'package:food_app/provider/cart.dart';
import 'package:food_app/provider/google_signin.dart';

import 'package:food_app/shared/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

// Fonction asynchrone principale qui initialise Firebase et lance l'application
Future<void> main() async {
  // Assure l'initialisation des widgets Flutter
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialise Firebase
  await Firebase.initializeApp();
  
  // Lance l'application MyApp
  runApp(const MyApp());
}

// Classe principale de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation de MultiProvider pour gérer plusieurs ChangeNotifierProviders
    return MultiProvider(
      providers: [
        // Crée un ChangeNotifierProvider pour la gestion du panier
        ChangeNotifierProvider(create: (context) {
          return Cart();
        }),
        
        // Crée un ChangeNotifierProvider pour la gestion de la connexion Google
        ChangeNotifierProvider(create: (context) {
          return GoogleSignInProvider();
        }),
      ],
      // Configuration de l'application MaterialApp
      child: MaterialApp(
        title: "myApp",
        debugShowCheckedModeBanner: false,
        // Utilisation d'un StreamBuilder pour gérer les changements d'état de l'authentification Firebase
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Affiche un indicateur de chargement si la connexion est en attente
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else if (snapshot.hasError) {
              // Affiche une Snackbar en cas d'erreur
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              // Redirige vers la page d'accueil si l'utilisateur est connecté
              return Home(); // home() OU VerifyEmailPage();
            } else {
              // Affiche la page de connexion si l'utilisateur n'est pas connecté
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
