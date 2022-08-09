import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fl_chart/fl_chart.dart';

class EmiCalcScreen extends StatefulWidget {
  const EmiCalcScreen({Key? key}) : super(key: key);

  @override
  State<EmiCalcScreen> createState() => _EmiCalcScreenState();
}

class _EmiCalcScreenState extends State<EmiCalcScreen> {
  double loanAmt = 5000000;
  double roi = 6;
  double tenure = 1;

  double finalAmt = 0;
  double interestAmt = 0;

  RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
  String Function(Match) mathFunc = (Match match) => '${match[1]},';

  calculate() {
    double r = roi.toInt() / 12 / 100;
    double n = (tenure.toInt()) * 12;
    double emi = (loanAmt * r * pow((1 + r), n) / (pow((1 + r), n) - 1));

    setState(() {
      finalAmt = (emi * n.toDouble().roundToDouble());
      interestAmt = (emi * n.toDouble().roundToDouble()) - loanAmt;
    });
  }

  @override
  void initState() {
    calculate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "EMI Calculator",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Loan Amt Slider
                        Text(
                          "Loan Amount:  ₹${loanAmt.round().toString().replaceAllMapped(reg, mathFunc)}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("₹ 50 Lac"),
                            Expanded(
                              child: Slider(
                                value: loanAmt,
                                min: 5000000,
                                max: 200000000,
                                onChanged: (value) {
                                  setState(() {
                                    loanAmt = value;
                                  });
                                  calculate();
                                },
                                divisions: 50,
                              ),
                            ),
                            const Text("₹ 20 Cr")
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Interest (% P.A):  ${roi.round().toString()}%",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("6"),
                            Expanded(
                              child: Slider(
                                value: roi,
                                min: 6,
                                max: 15,
                                divisions: 9,
                                onChanged: (value) {
                                  setState(() {
                                    roi = value;
                                  });
                                  calculate();
                                },
                              ),
                            ),
                            const Text("15")
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Tenure (years):  ${tenure.round().toString()}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            const Text("1"),
                            Expanded(
                              child: Slider(
                                value: tenure,
                                min: 1,
                                max: 30,
                                divisions: 30,
                                onChanged: (value) {
                                  setState(() {
                                    tenure = value;
                                  });
                                  calculate();
                                },
                              ),
                            ),
                            const Text("30")
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          "Monthly EMI:  ₹${(finalAmt / (tenure.round() * 12)).round().toString().replaceAllMapped(reg, mathFunc)}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          "Total Payable Amount:  ₹${finalAmt.round().toString().replaceAllMapped(reg, mathFunc)}",
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Stack(
                          children: [
                            AspectRatio(
                              aspectRatio: 1.2,
                              child: PieChart(
                                PieChartData(
                                  sectionsSpace: 0.0,
                                  centerSpaceRadius: 48.0,
                                  borderData: FlBorderData(show: false),
                                  sections: [
                                    PieChartSectionData(
                                      color: Colors.red,
                                      value: ((loanAmt / finalAmt) * 100),
                                      title:
                                          "${((loanAmt / finalAmt) * 100).round()}%",
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      radius: 60,
                                    ),
                                    PieChartSectionData(
                                      color: Colors.blue,
                                      value: ((interestAmt / finalAmt) * 100),
                                      title:
                                          "${((interestAmt / finalAmt) * 100).round()}%",
                                      titleStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      radius: 60,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: 0,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(4.0),
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: const SizedBox.shrink(),
                                          ),
                                          const Text("Principal")
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(4.0),
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(2),
                                            ),
                                            child: const SizedBox.shrink(),
                                          ),
                                          const Text("Interest")
                                        ],
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
            ),
          ),
        ),
      ),
    );
  }
}
