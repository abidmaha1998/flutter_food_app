// ignore_for_file: library_private_types_in_public_api
// La ligne ci-dessus ignore les avertissements liés à l'utilisation de types privés dans une API publique.

import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<Payment> {
  // Contrôleurs pour gérer les champs de saisie.
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold est la structure de base du design matériel.
      appBar: AppBar(
        title: const Text('Page de paiement'),
      ),
      body: Padding(
        // Padding pour ajouter de l'espace autour du contenu enfant.
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Titre et champ de saisie pour le numéro de carte.
            const Text('Numéro de carte'),
            TextFormField(
              controller: cardNumberController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '1234 5678 9012 3456',
              ),
            ),
            const SizedBox(height: 16), // Un espace vertical de 16 pixels.
            // Titre et champ de saisie pour la date d'expiration.
            const Text('Date d\'expiration'),
            TextFormField(
              controller: expiryDateController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'MM/AA',
              ),
            ),
            const SizedBox(height: 16),
            // Titre et champ de saisie pour le code CVV.
            const Text('CVV'),
            TextFormField(
              controller: cvvController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '123',
              ),
            ),
            const SizedBox(height: 16),
            // Titre et champ de saisie pour l'adresse.
            const Text('Adresse'),
            TextFormField(
              controller: addressController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: '123 rue principale, Ville, Pays',
              ),
            ),
            const SizedBox(height: 32),
            // Bouton d'élévation pour effectuer le paiement.
            ElevatedButton(
              onPressed: () {
                // La logique de traitement du paiement peut être ajoutée ici.
                _showPaymentSuccessDialog();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(appbarGreen),
                padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
              ),
              child: const Text(
                'Payer maintenant',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Affiche une boîte de dialogue de confirmation de paiement réussi.
  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Paiement réussi'),
          content: Text(
              'Merci pour votre paiement!\nAdresse : ${addressController.text}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  // runApp lance l'application en utilisant le widget MaterialApp et définissant la page d'accueil comme l'écran de paiement.
  runApp(const MaterialApp(
    home: Payment(),
  ));
}
