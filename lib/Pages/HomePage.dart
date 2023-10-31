import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgournd,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                    child: Image.network(
                      'https://m.media-amazon.com/images/M/MV5BN2UxOTMxY2UtN2VjZS00YTIyLWE4ODktNTgyMDIzNDRjMTdkXkEyXkFqcGdeQXVyMTMxMzcxODk1._V1_.jpg',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'name',
                        style: TextStyle(
                            color: Dark,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'age',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'weight',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 60,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'height',
                                  style: TextStyle(
                                      color: white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 50),
            Center(
              child: LinearPercentIndicator(
                // Set the width
                lineHeight: 16.0, // Set the thickness
                percent: 0.8,
                barRadius: Radius.circular(2),
                backgroundColor: Colors.grey,
                progressColor: primery, // You can use your custom color here
                center: Text(
                  '80%',
                  style: TextStyle(color: white),
                ), // Text in the center
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: light_primery),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BarcodeWidget(
                    data: '01001',
                    barcode: Barcode.code128(),
                    width: 240,
                    height: 60,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
