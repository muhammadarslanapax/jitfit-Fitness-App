import 'package:flutter/material.dart';
import 'package:jetfit/models/add_category.dart';
import 'package:jetfit/utilis/static_data.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/utilis/utilis.dart';
import 'package:jetfit/view/screens/paypal/subscription/pavement.dart';
import 'package:jetfit/view/screens/dashboard.dart';
import 'package:jetfit/view/screens/paypal/subscription/subscription_controller.dart';
import 'package:get/get.dart';

class SubscriptionSCreen extends StatefulWidget {
  const SubscriptionSCreen({super.key});

  @override
  State<SubscriptionSCreen> createState() => _SubscriptionSCreenState();
}

class _SubscriptionSCreenState extends State<SubscriptionSCreen> {
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, oreentation) {
          return GetBuilder<SubscriptionController>(
            initState: (state) {
              Get.put(SubscriptionController());
              // Get.put(PayPalINtegrationController());
              // PayPalINtegrationController.my.getAccessToken();
            },
            builder: (value) {
              return Container(
                height: height,
                width: width,
                color: MyThemeData.background,
                child: oreentation == Orientation.landscape
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.12,
                          ),
                          Container(
                            height: height * 0.85,
                            width: width * 0.33,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("images/home/persons.png")),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SizedBox(
                            height: height * 0.9,
                            width: width * 0.45,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Subscribe to Premium",
                                  style: TextStyle(
                                    fontSize: width * 0.025,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Subscribe to our services to start your fitness journey",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: width * 0.015,
                                  ),
                                ),
                                Text(
                                  "Our Plans",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.017,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "1 Month Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              "Start your 7-day free trial then \$7.99 / month. Subscription continues until cancelled",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: width * 0.015,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$07.99",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Radio(
                                            value: "7",
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            activeColor: Colors.white,
                                            groupValue: value.selectedDuration,
                                            onChanged: (String? v) {
                                              value.price = 7.99;
                                              value.duration = '1 Month';
                                              print(
                                                  "value.price ${value.price}");
                                              print(
                                                  "value.duration ${value.duration}");
                                              print(v);
                                              value.selectedDuration = v!;
                                              value.update();
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "3 Month Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              "Start your 7-day free trial then \$19.99 / 3 months. Subscription continues until cancelled",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: width * 0.015,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$19.99",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Radio(
                                            value: "19",
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            activeColor: Colors.white,
                                            groupValue: value.selectedDuration,
                                            onChanged: (v) {
                                              print(value);
                                              value.price = 19.99;
                                              value.duration = '3 Month';
                                              value.selectedDuration = v!;
                                              value.update();
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "12 Month Subscription",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.02,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: width * 0.3,
                                            child: Text(
                                              "Start your 7-day free trial then \$79.99 / 12 months. Subscription continues until cancelled",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: width * 0.015,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            "\$79.99",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.02,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Radio(
                                            value: '79',
                                            fillColor:
                                                MaterialStateColor.resolveWith(
                                                    (states) => Colors.white),
                                            activeColor: Colors.white,
                                            groupValue: value.selectedDuration,
                                            onChanged: (v) {
                                              value.price = 79.99;
                                              value.duration = '12 Month';
                                              value.selectedDuration = v!;
                                              value.update();
                                            },
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (Staticdata.uid != null &&
                                            value.duration != null) {
                                          // If user is authenticated, proceed with payment
                                          handlePayment(
                                              Staticdata.uid!,
                                              value.duration!,
                                              value.price!,
                                              context,
                                              VideossModel(price: ''));
                                        } else {
                                          showtoast(
                                              "please select atleast one package");
                                        }
                                        // PayPalINtegrationController.my
                                        //     .createSubscription();
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (context) =>
                                        //             const DashBoard()));
                                      },
                                      child: Container(
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Subscribe now",
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DashBoard()));
                                      },
                                      child: Container(
                                        height: height * 0.09,
                                        width: width * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Skip",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: height * 0.05,
                          ),
                          Container(
                            height: height * 0.34,
                            width: width * 0.8,
                            decoration: BoxDecoration(
                                image: const DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("images/home/persons.png")),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          Container(
                            height: height * 0.01,
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.08),
                              child: SizedBox(
                                // color: Colors.red,
                                height: height,
                                width: width * 0.9,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Subscribe to Premium",
                                      style: TextStyle(
                                        fontSize: width * 0.05,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Subscribe to our services to start your fitness journey",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: width * 0.03,
                                      ),
                                    ),
                                    Text(
                                      "Our Plans",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.035,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "1 Month Subscription",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.037,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.6,
                                                child: Text(
                                                  "Start your 7-day free trial then \$7.99 /3 month. Subscription continues until cancelled",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.03,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "\$07.99",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Radio(
                                                value: "7",
                                                fillColor: MaterialStateColor
                                                    .resolveWith(
                                                  (states) => Colors.white,
                                                ),
                                                activeColor: Colors.white,
                                                groupValue:
                                                    value.selectedDuration,
                                                onChanged: (String? v) {
                                                  value.price = 7.99;
                                                  value.duration = '1 Month';

                                                  value.selectedDuration = v!;
                                                  value.update();
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "3 Month Subscription",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.037,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.6,
                                                child: Text(
                                                  "Start your 7-day free trial then \$19.99 / 3 months. Subscription continues until cancelled",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.03,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "\$19.99",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Radio(
                                                value: "19",
                                                fillColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.white),
                                                activeColor: Colors.white,
                                                groupValue:
                                                    value.selectedDuration,
                                                onChanged: (String? v) {
                                                  value.price = 19.99;
                                                  value.duration = '3 Month';

                                                  value.selectedDuration = v!;
                                                  value.update();
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "12 Month Subscription",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.037,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              SizedBox(
                                                width: width * 0.6,
                                                child: Text(
                                                  "Start your 7-day free trial then \$79.99 / 12 months. Subscription continues until cancelled",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: width * 0.03,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "\$79.99",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.035,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Radio(
                                                value: "79",
                                                fillColor: MaterialStateColor
                                                    .resolveWith((states) =>
                                                        Colors.white),
                                                activeColor: Colors.white,
                                                groupValue:
                                                    value.selectedDuration,
                                                onChanged: (String? v) {
                                                  value.price = 79.99;
                                                  value.duration = '12 Month';
                                                  print(
                                                      "value.price ${value.price}");
                                                  print(
                                                      "value.duration ${value.duration}");
                                                  print(v);

                                                  value.selectedDuration = v!;

                                                  value.update();
                                                },
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (Staticdata.uid != null &&
                                                value.duration != null) {
                                              // If user is authenticated, proceed with payment
                                              handlePayment(
                                                  Staticdata.uid!,
                                                  value.duration!,
                                                  value.price!,
                                                  context,
                                                  VideossModel(price: ''));
                                            } else {
                                              showtoast(
                                                  "please select atleast one package");
                                            }

                                            // PayPalINtegrationController.my
                                            //     .createSubscription();
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             SubscriptionPage())
                                            //     controller:
                                            //         WebViewController()
                                            //           ..setJavaScriptMode(
                                            //               JavaScriptMode
                                            //                   .unrestricted)
                                            //           ..setBackgroundColor(
                                            //               const Color(
                                            //                   0x00000000))
                                            //           ..setNavigationDelegate(
                                            //             NavigationDelegate(
                                            //               onProgress: (int
                                            //                   progress) {},
                                            //               onPageStarted:
                                            //                   (String url) {},
                                            //               onPageFinished:
                                            //                   (String url) {},
                                            //               onWebResourceError:
                                            //                   (WebResourceError
                                            //                       error) {},
                                            //               onNavigationRequest:
                                            //                   (NavigationRequest
                                            //                       request) {
                                            //                 if (request.url
                                            //                     .startsWith(
                                            //                         "https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-7VL01457RG826213HMTZEEJA")) {
                                            //                   return NavigationDecision
                                            //                       .prevent;
                                            //                 }
                                            //                 return NavigationDecision
                                            //                     .navigate;
                                            //               },
                                            //             ),
                                            //           )
                                            //           ..loadRequest(Uri.parse(
                                            //               "https://www.paypal.com/webapps/billing/plans/subscribe?plan_id=P-7VL01457RG826213HMTZEEJA")),
                                            //   ),
                                            // ),
                                            // );
                                          },
                                          child: Container(
                                            height: height * 0.055,
                                            width: width * 0.35,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Subscribe now",
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.08,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const DashBoard(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: height * 0.055,
                                            width: width * 0.35,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Skip",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.05,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
            },
          );
        },
      ),
    );
  }
}
