// Importation des packages nécessaires pour interagir avec Firebase et pour la création d'interfaces utilisateur Flutter
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Widget ImgUser qui affiche l'image de profil de l'utilisateur
class ImgUser extends StatefulWidget {
  const ImgUser({
    super.key,
  });

  @override
  State<ImgUser> createState() => _ImgUserState();
}

class _ImgUserState extends State<ImgUser> {
  // Récupération des informations d'authentification de l'utilisateur actuel
  final credential = FirebaseAuth.instance.currentUser;

  // Référence à la collection 'userSSS' dans Firestore
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');

  @override
  Widget build(BuildContext context) {
    // Référence à la collection 'userSSS' dans Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('userSSS');

    // Utilisation de FutureBuilder pour gérer les états de chargement des données depuis Firestore
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(credential!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          // Affiche un message d'erreur si quelque chose ne fonctionne pas
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          // Affiche un message si le document n'existe pas
          return const Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          // Récupère les données du document Firestore
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          // Retourne un CircleAvatar avec l'image de profil de l'utilisateur
          return CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 225, 225, 225),
            radius: 71,
            // Utilise l'URL de l'image stockée dans Firestore pour afficher l'image
            backgroundImage: NetworkImage(data["imgLink"]),
          );
        }

        // Affiche un message de chargement pendant que les données sont récupérées
        return const Text("loading");
      },
    );
  }
}
