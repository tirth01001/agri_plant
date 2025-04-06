


import 'package:agriplant/models/product.dart';
import 'package:agriplant/service/firebase_service.dart';
import 'package:agriplant/service/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';

class PaypalPayment extends StatelessWidget {
  
  final List<Product> cartProducts;
  const PaypalPayment({super.key,required this.cartProducts});

  @override
  Widget build(BuildContext context) {
    return PaypalCheckoutView(
      sandboxMode: true,
      clientId: "ATYYGKxLjgijv0HkRD1aJmAbxpvzYtfCVUd0sVQ1p9OQpAbpMR2UCw8vATffHQroH4plUcMurUA69a-w",
      secretKey: "EIs4_k3NN6qkhIgqxhbo__6ccrFGeoFG0uPTWNONY06Q0zMoPRNYv1PT34qLF8W-z8uRdBOMU7Cq5guy",
      transactions: const [
        {
          "amount": {
            "total": '100',
            "currency": "USD",
            "details": {
              "subtotal": '100',
              "shipping": '0',
              "shipping_discount": 0
            }
          },
          "description": "The payment transaction description.",
          // "payment_options": {
          //   "allowed_payment_method":
          //       "INSTANT_FUNDING_SOURCE"
          // },
          "item_list": {
            "items": [
              {
                "name": "Apple",
                "quantity": 4,
                "price": '10',
                "currency": "USD"
              },
              {
                "name": "Pineapple",
                "quantity": 5,
                "price": '12',
                "currency": "USD"
              }
            ],

            // Optional
            //   "shipping_address": {
            //     "recipient_name": "Tharwat samy",
            //     "line1": "tharwat",
            //     "line2": "",
            //     "city": "tharwat",
            //     "country_code": "EG",
            //     "postal_code": "25025",
            //     "phone": "+00000000",
            //     "state": "ALex"
            //  },
          }
        }
      ],
      note: "Contact us for any questions on your order.",
      onSuccess: (Map params) async {
        // log("onSuccess: $params");
        Loading(
          context, 
          process: FirebaseService.service.makeOrders(cartProducts)
        ).executeProcess();
        Navigator.pop(context);
      },
      onError: (error) {
        // log("onError: $error");
        Navigator.pop(context);
      },
      onCancel: () {
        // print('cancelled:');
        Navigator.pop(context);
      },
    );
  }
}