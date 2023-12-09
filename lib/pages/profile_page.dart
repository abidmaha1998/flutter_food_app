import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_app/pages/sign_in.dart';
import 'package:food_app/shared/data_from_firestore.dart';
import 'package:food_app/shared/user_img_from_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' show basename;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Utilisateur actuellement connecté.
  final credential = FirebaseAuth.instance.currentUser;

  // Fichier image pour l'avatar.
  File? imgPath;

  // Nom de l'image.
  String? imgName;

  // Référence à la collection d'utilisateurs dans Firestore.
  CollectionReference users = FirebaseFirestore.instance.collection('userSSS');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Bouton de déconnexion dans la barre d'applications.
        actions: [
          TextButton.icon(
            onPressed: () {
               Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
            },
            label: const Text(
              "Déconnexion",
              
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          )
        ],
        backgroundColor: appbarGreen,
        title: const Text("Profil Page",style: TextStyle(color: Colors.white),
),
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(125, 78, 91, 110),
                  ),
                  child: Stack(
                    children: [
                      // Affichage de l'image de profil si elle existe, sinon affichage de l'avatar par défaut.
                      imgPath == null
                          ? const ImgUser()
                          : ClipOval(
                              child: Image.file(
                                imgPath!,
                                width: 145,
                                height: 145,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Center(
                  child: Container(
                padding: const EdgeInsets.all(11),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(250, 197, 118, 1),
                    borderRadius: BorderRadius.circular(11)),
                child: const Text(
                  "Informations User",
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    "Email: ${credential!.email}      ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    // Affichage de la date de création du compte utilisateur.
                    "Date de création:   ${DateFormat("MMMM d, y").format(credential!.metadata.creationTime!)}   ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(
                    height: 11,
                  ),
                  Text(
                    // Affichage de la dernière connexion de l'utilisateur.
                    "Dernière connexion: ${DateFormat("MMMM d, y").format(credential!.metadata.lastSignInTime!)}  ",
                    style: const TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 22,
              ),

              Center(
                  child: Container(
                      padding: const EdgeInsets.all(11),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(250, 197, 118, 1),
                          borderRadius: BorderRadius.circular(11)),
                      child: const Text(
                        "Update User",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ))),
              // Affichage des données supplémentaires depuis Firestore.
              GetDataFromFirestore(
                documentId: credential!.uid,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
