import 'package:food_app/pages/Livreson.dart';
import 'package:food_app/provider/cart.dart';
import 'package:food_app/shared/appbar.dart';
import 'package:food_app/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupération de l'état actuel du panier à partir du fournisseur.
    final carttt = Provider.of<Cart>(context);

    return Scaffold(
      // Scaffold est la structure de base du design matériel.
      appBar: AppBar(
        // Barre d'applications avec une couleur de fond personnalisée et un titre.
        backgroundColor: appbarGreen,
        title: const Text("Checkout Screen",style: TextStyle(color: Colors.white),
),
        // Actions de la barre d'applications, affiche le total des produits et le prix.
        actions: const [ProductsAndPrice()],
      ),
      // Corps de la page, contient la liste des produits sélectionnés et le bouton de paiement.
      body: Column(
        children: [
          // Utilisation d'un SingleChildScrollView pour permettre le défilement vertical dans le cas où la liste est trop longue.
          SingleChildScrollView(
            child: SizedBox(
              height: 550,
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: carttt.selectedProducts.length,
                itemBuilder: (BuildContext context, int index) {
                  // Carte représentant chaque produit sélectionné avec son nom, son prix, son emplacement, son image et un bouton de suppression.
                  return Card(
                    child: ListTile(
                      title: Text(carttt.selectedProducts[index].name),
                      subtitle: Text(
                        "${carttt.selectedProducts[index].price} - ${carttt.selectedProducts[index].location}",
                      ),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          carttt.selectedProducts[index].imgPath,
                        ),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          // Suppression du produit du panier lorsqu'on appuie sur le bouton de suppression.
                          carttt.delete(carttt.selectedProducts[index]);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Bouton élevé qui permet de passer à la page de paiement (PaymentPage).
          ElevatedButton(
            onPressed: () {
              // Navigation vers la page de paiement (PaymentPage).
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Payment()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(appbarGreen),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
            ),
            child: Text(
              "Pay ${carttt.price} Dt",
              style: const TextStyle(fontSize: 19, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
