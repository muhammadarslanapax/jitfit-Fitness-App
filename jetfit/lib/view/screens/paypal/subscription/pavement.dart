// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'package:jetfit/utilis/theme_data.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import 'package:flutter/material.dart';
// Import Firebase Auth
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
import 'package:flutter_paypal/flutter_paypal.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';
// class Payment extends StatefulWidget {
//   WebViewController? controller;

//   final Function? onFinish;

//   Payment({this.onFinish, required this.controller});

//   @override
//   State<StatefulWidget> createState() {
//     return PaymentState();
//   }
// }

// class PaymentState extends State<Payment> {
//   final _globalKey = GlobalKey<ScaffoldMessengerState>();
//   String? checkoutUrl;
//   String? executeUrl;
//   String? accessToken;
//   // Services services = Services();

//   // you can change default currency according to your need
//   // Map<dynamic, dynamic> defaultCurrency = {
//   //   "symbol": "USD ",
//   //   "decimalDigits": 2,
//   //   "symbolBeforeTheNumber": true,
//   //   "currency": "USD"
//   // };

//   bool isEnableShipping = false;
//   bool isEnableAddress = false;

//   String returnURL = 'return.example.com';
//   String cancelURL = 'cancel.example.com';

//   @override
//   void initState() {
//     super.initState();
//   }

//   // // item name, price and quantity
//   // String itemName = 'iPhone 7';
//   // String itemPrice = '200';
//   // int quantity = 1;

//   // Map<String, dynamic> getOrderParams() {
//   //   List items = [
//   //     {
//   //       "name": itemName,
//   //       "quantity": quantity,
//   //       "price": itemPrice,
//   //       "currency": defaultCurrency["currency"]
//   //     }
//   //   ];

//   //   // checkout invoice details
//   //   String totalAmount = '200';
//   //   String subTotalAmount = '200';
//   //   String shippingCost = '0';
//   //   int shippingDiscountCost = 0;
//   //   String userFirstName = 'Arsalan';
//   //   String userLastName = 'Umar';
//   //   String addressCity = 'Islamabad';
//   //   String addressStreet = "i-10";
//   //   String addressZipCode = '44000';
//   //   String addressCountry = 'Pakistan';
//   //   String addressState = 'Islamabad';
//   //   String addressPhoneNumber = '+923200811288';

//   //   Map<String, dynamic> temp = {
//   //     "intent": "sale",
//   //     "payer": {"payment_method": "paypal"},
//   //     "transactions": [
//   //       {
//   //         "amount": {
//   //           "total": totalAmount,
//   //           "currency": defaultCurrency["currency"],
//   //           "details": {
//   //             "subtotal": subTotalAmount,
//   //             "shipping": shippingCost,
//   //             "shipping_discount": ((-1.0) * shippingDiscountCost).toString()
//   //           }
//   //         },
//   //         "description": "The payment transaction description.",
//   //         "payment_options": {
//   //           "allowed_payment_method": "INSTANT_FUNDING_SOURCE"
//   //         },
//   //         "item_list": {
//   //           "items": items,
//   //           if (isEnableShipping && isEnableAddress)
//   //             "shipping_address": {
//   //               "recipient_name": userFirstName + " " + userLastName,
//   //               "line1": addressStreet,
//   //               "line2": "",
//   //               "city": addressCity,
//   //               "country_code": addressCountry,
//   //               "postal_code": addressZipCode,
//   //               "phone": addressPhoneNumber,
//   //               "state": addressState
//   //             },
//   //         }
//   //       }
//   //     ],
//   //     "note_to_payer": "Contact us for any questions on your order.",
//   //     "redirect_urls": {"return_url": returnURL, "cancel_url": cancelURL}
//   //   };
//   //   return temp;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _globalKey,
//       appBar: AppBar(
//         backgroundColor: MyThemeData.background,
//         leading: GestureDetector(
//           child: Icon(Icons.arrow_back_ios),
//           onTap: () => Navigator.pop(context),
//         ),
//       ),
//       body: WebViewWidget(
//         controller: widget.controller!,
//       ),
//     );
//     // } else {
//     //   return Scaffold(
//     //     key: _globalKey,
//     //     appBar: AppBar(
//     //       leading: IconButton(
//     //           icon: Icon(Icons.arrow_back_ios),
//     //           onPressed: () {
//     //             Navigator.of(context).pop();
//     //           }),
//     //       backgroundColor: MyThemeData.background,
//     //       elevation: 0.0,
//     //     ),
//     //     body: Center(child: Container(child: SpinkitFlutter.spinkit)),
//     //   );
//     // }
//   }
// }

// class SubscriptionPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Subscription Plans'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SubscriptionButton(
//               duration: '1 Month',
//               price: 7.99,
//             ),
//             SubscriptionButton(
//               duration: '3 Months',
//               price: 19.99,
//             ),
//             SubscriptionButton(
//               duration: '12 Months',
//               price: 79.99,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class SubscriptionButton extends StatelessWidget {
//   final String duration;
//   final double price;

//   SubscriptionButton({required this.duration, required this.price});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () async {

//       },
//       child: Text('Subscribe for $duration - \$$price'),
//     );
//   }

void handlePayment(String uid, String duration, double price,
    BuildContext context, VideossModel model) {
  // Proceed with the PayPal payment
  Navigator.of(context).push(
    MaterialPageRoute(
      builder: (BuildContext context) {
        return UsePaypal(
          sandboxMode: true,
          clientId:
              "AeKOVoTfDqKh4jxc8x-w4OKJjYBHs4KIzIxKU9iYvRbJ5Um9uhzX3n_wTDJuekFqDSOHJnP-WvK557Vg",
          secretKey:
              "EJm92KYJ9WeSBfD7BPpmk5v8QGkMZVg8kGC1yLINYDnukgDZRORbz0S5zbO5DrkwYFYj1ugU4Lr72LBl",
          returnURL: "https://samplesite.com/return",
          cancelURL: "https://samplesite.com/cancel",
          transactions: [
            {
              "amount": {
                "total": price.toStringAsFixed(2),
                "currency": "USD",
                "details": {
                  "subtotal": price.toStringAsFixed(2),
                  "shipping": '0',
                  "shipping_discount": 0,
                },
              },
              "description": "Subscription for $duration",
              "item_list": {
                "items": [
                  {
                    "name": "Subscription",
                    "quantity": 1,
                    "price": price.toStringAsFixed(2),
                    "currency": "USD",
                  },
                ],
              },
            },
          ],
          note: "Contact us for any questions on your order.",
          onSuccess: (Map params) async {
            print("onSuccess: $params");

            // After successful payment, save the subscription record
            await storeSubscriptionRecord(uid, duration, price, model);

            // Handle success callback
            // You can show a success message or navigate to a success screen
          },
          onError: (error) {
            print("onError: $error");
            // Handle error callback
            // You can show an error message or handle the error accordingly
          },
          onCancel: (params) {
            print('cancelled: $params');
            // Handle cancellation callback
            // You can show a cancellation message or handle it accordingly
          },
        );
      },
    ),
  );
}

Future<void> storeSubscriptionRecord(
    String userId, String duration, double price, VideossModel model) async {
  try {
    if (duration == "exclusive content") {
      FirebaseFirestore.instance
          .collection("favourite")
          .doc(Staticdata.uid)
          .collection("exclusive")
          .doc(model.videoID)
          .set(model.toMap());
    } else {
      Timestamp currentTime = Timestamp.now();
      final Map<String, int> durationMonths = {
        "1 Month": 1,
        "3 Month": 3,
        "12 Month": 12,
      };

      int monthsToAdd = durationMonths[duration] ??
          1; // Default to 1 month if duration is not found
      DateTime endTime =
          currentTime.toDate().add(Duration(days: 30 * monthsToAdd));
      final CollectionReference subscriptionsCollection =
          FirebaseFirestore.instance.collection('subscriptions');

      subscriptionsCollection
          .where('userId', isEqualTo: Staticdata.uid)
          .where('activity', isEqualTo: "activate")
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          value.docs.forEach((element) {
            element.reference.update({'activity': 'deactivate'}).then((_) {
              print("Updated 'activity' to 'deactivate'");
            }).catchError((error) {
              print("Error updating 'activity': $error");
            });
          });
        }
      });

      await subscriptionsCollection.add({
        'userId': Staticdata.uid,
        'duration': duration,
        'activity': "activate",
        'price': price,
        'timestamp': FieldValue.serverTimestamp(),
        'subscriptionEndTime': endTime,
      });
      print(
        'Subscription record stored successfully.',
      );
    }
  } catch (e) {
    print('Error storing subscription record: $e');
  }
}
    
// }
