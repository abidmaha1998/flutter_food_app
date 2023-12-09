import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';

// Classe StatefulWidget pour la page de paiement.
class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

// Classe d'état pour la page de paiement.
class _PaymentPageState extends State<Payment> {
  // Contrôleurs pour les champs de saisie.
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Page', style: TextStyle(color: Colors.white)),
        backgroundColor: appbarGreen,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              // Utilisation de Positioned dans un widget Center n'a pas d'effet, nous devrions ajuster cela
              Center(
                child: Image.asset(
                  "assets/img/card.png",
                  width: 288,
                ),
              ),
              SizedBox(height: 16),
              // Carte pour encadrer les champs de saisie de la carte de crédit.
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Card number'),
                      TextField(
                        controller: cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '1234 5678 9012 3456',
                        ),
                      ),
                      SizedBox(height: 16),
                      // Deux champs dans une rangée pour la date d'expiration et le CVV.
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Champ pour la date d'expiration.
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Expiration date'),
                                TextField(
                                  controller: expiryDateController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'MM/YY',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          // Champ pour le CVV.
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('CVV'),
                                TextField(
                                  controller: cvvController,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: '123',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32),
              // Bouton pour effectuer le paiement.
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // La logique de traitement du paiement peut être ajoutée ici.
                    _showPaymentSuccessDialog();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(255, 151, 0, 1.0), 
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Pay now',
                    style: TextStyle(color:Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Méthode pour afficher une boîte de dialogue de succès de paiement.
  void _showPaymentSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Payment successful'),
          content: Text('Thank you for your payment !'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

// Fonction principale pour exécuter l'application.
void main() {
  runApp(MaterialApp(
    home: Payment(),
  ));
}
