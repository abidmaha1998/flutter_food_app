import 'package:food_app/pages/checkout.dart';
import 'package:food_app/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsAndPrice extends StatelessWidget {
  const ProductsAndPrice({super.key});

  @override
  Widget build(BuildContext context) {
    final carttt = Provider.of<Cart>(context);
    return Row(
      children: [
        Stack(
          children: [
            Positioned(
              bottom: 24,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(163, 98, 1, 1),
                      shape: BoxShape.circle),
                  child: Text(
                    "${carttt.itemCount}",
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                  )),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CheckOut(),
                  ),
                );
              },
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: Text(
            " ${carttt.price} Dt",
            style: const TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
