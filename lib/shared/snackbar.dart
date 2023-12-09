// Importation du package Flutter pour les widgets et l'interface utilisateur
import 'package:flutter/material.dart';

// Fonction pour afficher un SnackBar avec un texte donné
showSnackBar(BuildContext context, String text) {
  // Utilisation de ScaffoldMessenger.of(context) pour obtenir le Scaffold actuel
  // et afficher un SnackBar avec le texte fourni
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    // Définition de la durée du SnackBar à une journée (longue durée)
    duration: const Duration(days: 1),
    // Contenu du SnackBar avec le texte spécifié
    content: Text(text),
    // Action du SnackBar avec un bouton "close" qui ne fait rien lorsqu'il est pressé
    action: SnackBarAction(label: "close", onPressed: () {}),
  ));
}
