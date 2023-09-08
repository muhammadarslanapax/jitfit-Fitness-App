import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:countup/countup.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:jetfit/utilis/theme_data.dart';
import 'package:jetfit/web_view/home_screen/dashboard_screen/dashboard_controller.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart' as pie;

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  var height, width;
  List<Color> colorList = [
    Colors.red.shade200,
    Colors.black54,
    Colors.brown.shade300,
  ];
  List<FlSpot> dataPoints = [
    const FlSpot(0, 5), // Data point with x=0 and y=5
    const FlSpot(1, 10), // Data point with x=1 and y=10
    const FlSpot(2, 7),
    const FlSpot(3, 3), // Data point with x=2 and y=7
    const FlSpot(4, 5),
    const FlSpot(5, 8),
    const FlSpot(7, 10),
    const FlSpot(8, 2),
    const FlSpot(9, 4),
    const FlSpot(10, 7),
    const FlSpot(11, 1),
    const FlSpot(12, 0), //

    // Add more data points as needed...
  ];
  double totalIncomeAmount = 0;
  double totalexpAmount = 0;

  String convertToKBchart(int value) {
    double value1 = 100000 * value / 10;
    // Convert the value into K, M, or B format as needed
    if (value1 >= 1000000000000000) {
      return '${(value1 / 1000000000000000).toStringAsFixed(0)}Q';
    } else if (value1 >= 10000000000000) {
      return '${(value1 / 10000000000000).toStringAsFixed(0)}T';
    } else if (value1 >= 1000000000) {
      //  return '${(value1 / 1000000).toStringAsFixed(0)}M';

      return '${(value1 / 1000000000).toStringAsFixed(0)}B';
    } else if (value1 >= 1000000) {
      return '${(value1 / 1000000).toStringAsFixed(0)}M';
    } else if (value1 >= 1000) {
      return '${(value1 / 1000).toStringAsFixed(0)}K';
    } else if (value1 >= 100) {
      return '${(value1 / 100).toStringAsFixed(0)}H';
    } else {
      return value1.toString();
    }
  }

  Widget leftTitlesWidget(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 9
        // fontSize: 14,
        );

    String text;
    switch (value.toInt()) {
      case 2:
        text = convertToKBchart(2);
        break;
      // case 6:
      //   text = '30K';
      //   break;
      case 6:
        text = convertToKBchart(6);
        break;
      case 10:
        text = convertToKBchart(10);
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 0,
      child: Text(text, style: style),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      '',
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11',
      '12'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
          color: Color(0xff7589a2), fontWeight: FontWeight.bold, fontSize: 9
          // fontSize: 14,
          ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      // space: 16, //margin top
      child: text,
    );
  }

  List<Color> gradientColors = [
    Colors.black,
    Colors.brown,
  ];

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: MyThemeData.background,
      body: GetBuilder<DashboardController>(initState: (state) {
        Get.put(DashboardController());
        DashboardController.to.getcataories();
        DashboardController.to.postinstructiorlist();
      }, builder: (obj) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: width * 0.05,
              ),
              width: width,
              height: height * 0.1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {},
                  child: const Text(
                    "ADMIN DASHBOARD",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                height: height * 0.85,
                width: width,
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: obj.firebasefirestore
                                .collection("User")
                                .snapshots(),
                            builder: (context, snapshot) {
                              return Card(
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: height * 0.17,
                                  width: width * 0.18,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: width * 0.015,
                                      ),
                                      Image(
                                        height: height * 0.07,
                                        width: width * 0.07,
                                        image:
                                            const AssetImage('images/user.png'),
                                      ),
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ?
                                          // While data is loading
                                          Center(
                                              child: SpinKitThreeBounce(
                                                color: MyThemeData.whitecolor,
                                                size: 25.0,
                                              ),
                                            )
                                          : snapshot.hasData
                                              ? Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Countup(
                                                      begin: 0,
                                                      end: double.parse(snapshot
                                                          .data!.docs.length
                                                          .toString()),
                                                      duration: const Duration(
                                                          seconds: 1),
                                                      separator: '',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 28,
                                                          color: Colors.white),
                                                    ),
                                                    // Text(
                                                    //   snapshot.data!.docs.length
                                                    //       .toString(),
                                                    //   style: const TextStyle(
                                                    //       fontWeight:
                                                    //           FontWeight.bold,
                                                    //       fontSize: 28,
                                                    //       color: Colors.white),
                                                    // ),
                                                    const Text(
                                                      "Total Users",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                )
                                              : const Text(
                                                  "No Data",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 28,
                                                      color: Colors.white),
                                                ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.17,
                            width: width * 0.18,
                            child: Row(
                              children: [
                                Image(
                                  height: height * 0.07,
                                  width: width * 0.07,
                                  image: const AssetImage('images/free.png'),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: obj.publicDocsList.isEmpty
                                        ?
                                        // While data is loading
                                        Center(
                                            child: SpinKitThreeBounce(
                                              color: MyThemeData.whitecolor,
                                              size: 25.0,
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: double.parse(obj
                                                    .publicDocsList.length
                                                    .toString()),
                                                duration:
                                                    const Duration(seconds: 1),
                                                separator: '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    color: Colors.white),
                                              ),
                                              // Text(
                                              //   obj.publicDocsList.length
                                              //       .toString(),
                                              //   textAlign: TextAlign.start,
                                              //   style: const TextStyle(
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: 28,
                                              //       color: Colors.white),
                                              // ),
                                              const Text(
                                                "Public Videos",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.17,
                            width: width * 0.18,
                            child: Row(
                              children: [
                                Image(
                                  height: height * 0.07,
                                  width: width * 0.07,
                                  image: const AssetImage('images/premium.png'),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: obj.premiumDocsList.isEmpty
                                        ?
                                        // While data is loading
                                        Center(
                                            child: SpinKitThreeBounce(
                                              color: MyThemeData.whitecolor,
                                              size: 25.0,
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: double.parse(obj
                                                    .premiumDocsList.length
                                                    .toString()),
                                                duration:
                                                    const Duration(seconds: 1),
                                                separator: '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    color: Colors.white),
                                              ),
                                              // Text(
                                              //   obj.premiumDocsList.length
                                              //       .toString(),
                                              //   textAlign: TextAlign.start,
                                              //   style: const TextStyle(
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: 28,
                                              //       color: Colors.white),
                                              // ),
                                              const Text(
                                                "Premium Videos",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.17,
                            width: width * 0.18,
                            child: Row(
                              children: [
                                Image(
                                  height: height * 0.07,
                                  width: width * 0.07,
                                  image:
                                      const AssetImage('images/exclusive.png'),
                                ),
                                Expanded(
                                  child: SizedBox(
                                    width: width * 0.1,
                                    child: obj.exclusiveDocsList.isEmpty
                                        ?
                                        // While data is loading
                                        Center(
                                            child: SpinKitThreeBounce(
                                              color: MyThemeData.whitecolor,
                                              size: 25.0,
                                            ),
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Countup(
                                                begin: 0,
                                                end: double.parse(obj
                                                    .exclusiveDocsList.length
                                                    .toString()),
                                                duration:
                                                    const Duration(seconds: 1),
                                                separator: '',
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 28,
                                                    color: Colors.white),
                                              ),
                                              // Text(
                                              //   obj.exclusiveDocsList.length
                                              //       .toString(),
                                              //   textAlign: TextAlign.start,
                                              //   style: const TextStyle(
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: 28,
                                              //       color: Colors.white),
                                              // ),
                                              const Text(
                                                "Exclusive Videos",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.55,
                            width: width * 0.51,
                            child: Padding(
                              padding: const EdgeInsets.all(50.0),
                              child: LineChart(
                                  // LineChartData(

                                  LineChartData(
                                lineTouchData:
                                    const LineTouchData(enabled: false),
                                gridData: FlGridData(
                                  show: true,
                                  drawHorizontalLine: true,
                                  verticalInterval: 1,
                                  horizontalInterval: 1,
                                  getDrawingVerticalLine: (value) {
                                    return const FlLine(
                                      color: Color(0xff37434d),
                                      strokeWidth: 0.5,
                                    );
                                  },
                                  getDrawingHorizontalLine: (value) {
                                    return const FlLine(
                                      color: Color(0xff37434d),
                                      strokeWidth: 0.05,
                                    );
                                  },
                                ),
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      reservedSize: 30,
                                      getTitlesWidget: bottomTitles,
                                      interval: 1,
                                    ),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      getTitlesWidget: leftTitlesWidget,
                                      reservedSize: 45,
                                      interval: 1,
                                    ),
                                  ),
                                  topTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: const AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(
                                      color: const Color(0xff37434d)),
                                ),
                                minX: 0,
                                maxX: 12,
                                minY: -0.58,
                                maxY: 14,
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: dataPoints,
                                    isCurved: true,
                                    gradient: LinearGradient(
                                      colors: [
                                        gradientColors[0],
                                        gradientColors[1],
                                      ],
                                    ),
                                    barWidth: 2,
                                    isStrokeJoinRound: false,
                                    preventCurveOverShooting: false,
                                    isStrokeCapRound: false,
                                    dotData: const FlDotData(
                                      show: false,
                                    ),
                                    belowBarData: BarAreaData(
                                      show: true,
                                      gradient: LinearGradient(
                                        colors: [
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!
                                              .withOpacity(0.1),
                                          ColorTween(
                                                  begin: gradientColors[0],
                                                  end: gradientColors[1])
                                              .lerp(0.2)!
                                              .withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: height * 0.55,
                            width: width * 0.25,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                if (obj.dataMap.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: pie.PieChart(
                                      dataMap: obj.dataMap,
                                      animationDuration:
                                          const Duration(milliseconds: 800),
                                      chartLegendSpacing: 32,
                                      chartRadius:
                                          MediaQuery.of(context).size.width /
                                              3.2,
                                      initialAngleInDegree: 0,
                                      ringStrokeWidth: 32,
                                      centerText: "Videos",
                                      legendOptions: const pie.LegendOptions(
                                        showLegendsInRow: false,
                                        legendPosition:
                                            pie.LegendPosition.right,
                                        showLegends: true,
                                        legendTextStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      chartValuesOptions:
                                          const pie.ChartValuesOptions(
                                        showChartValueBackground: true,
                                        showChartValues: true,
                                        showChartValuesInPercentage: false,
                                        showChartValuesOutside: false,
                                        decimalPlaces: 1,
                                      ),
                                      colorList:
                                          colorList, // Assign the custom colors to the chart
                                    ),
                                  ),
                                if (obj.dataMap.isEmpty)
                                  Center(
                                    child: SpinKitThreeBounce(
                                      color: MyThemeData.background,
                                      size: 25.0,
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget lableTextname(String title) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
          top: height * 0.015, bottom: height * 0.01, left: width * 0.03),
      child: Text(
        title,
        style: TextStyle(
          color: MyThemeData.background,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
