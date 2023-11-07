import 'dart:convert';

import 'package:gymapp/utils/apiurl.dart';
import 'package:intl/intl.dart';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/models/Customermodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../Config/ToList.dart';
import '../Config/dataconverter.dart';
import '../models/ResultModel.dart';
import '../provider/provider.dart';

class HomePage extends StatefulWidget {
  final int id;
  HomePage({super.key, required this.id});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String data;
  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DataProvider _provider;
  Customermodel? result;

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);

    print(widget.id);
    if (widget.id == null) {
      print('no value exist');
    } else {
      Getuser(widget.id);
    }
  }

  Future<void> Getuser(int id) async {
    var res = await _provider.ShowcustomerData(id);
    print(res.data);
    if (res.statusCode == 200) {
      result = Customermodel.fromJson(jsonDecode(res.data));
      setState(() {});
    }
  }

  Future<List<Customermodel>> Gethistory(int id) async {
    var res = await _provider.ShowHistory(id);
    print(res.data);
    if (res.statusCode == 200) {
      print(res.data);
      return itemsCategoriesFromJson(res.data);
    } else {
      return List.empty();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        centerTitle: true,
        title: Text(
          'Homepage',
          style: TextStyle(color: Dark),
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                  child: ClipOval(
                    child: Image.network(
                      '${apiurl}Customer/getImage?id=${widget.id}',
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 2, 8, 8),
                        child: Text(
                          result == null
                              ? "name"
                              : result!.cusFname! + ' ' + result!.cusLname!,
                          style: TextStyle(
                              color: Dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
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
                            padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
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
                            padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
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
                ),
              ]),

              SizedBox(height: 10),

              Container(
                width: 100,
                height: 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: primery, width: 2)),
                child: Center(
                    child: Text(
                  'Show Barcode',
                  style: TextStyle(color: primery, fontWeight: FontWeight.bold),
                )),
              ),
              SizedBox(height: 7),
              Divider(thickness: 2, color: Dark),

              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Icon(
                                Icons.settings_outlined,
                                color: Dark,
                                size: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'settings',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.fitness_center_outlined,
                              color: Dark,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Show Workouts',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: Dark,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Show Diet',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              Divider(thickness: 2, color: Dark),
              // CircularPercentIndicator(
              //   // Set the width
              //   percent: 0.10,
              //   radius: 70.0,
              //   lineWidth: 10.0,
              //   // Set a default value (e.g., 0.0) if either value is null
              //   backgroundColor: Colors.grey,
              //   progressColor: primery, // You can use your custom color here
              //   center: Text(
              //     'days : ' +
              //         (result == null ? '0' : result!.indays!.toString()),
              //     style: TextStyle(color: primery),
              //   ),

              //   // Text in the center
              // ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: white,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              tabBorderRadius: 8,
              backgroundColor: white,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: primery,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.add_box_rounded,
                  text: 'Request',
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.history_sharp,
                  text: 'History',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
