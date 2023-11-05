import 'dart:convert';
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
      Getuser(widget.id!);
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: AppBar(
          elevation: 0,
          backgroundColor: second_bg,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.settings,
                  color: primery,
                  size: 24,
                ))
          ],
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                height: 260,
                decoration: BoxDecoration(
                    color: second_bg,
                    borderRadius: BorderRadiusDirectional.only(
                        bottomEnd: Radius.circular(40),
                        bottomStart: Radius.circular(40))),
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: ClipOval(
                      child: Image.network(
                        'https://192.168.1.70:45455/api/Customer/getImage?id=${widget.id}',
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
              ),

              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8), color: white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BarcodeWidget(
                      data: result == null ? "0000" : result!.cusCode!,
                      barcode: Barcode.code128(),
                      width: 240,
                      height: 60,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              LinearPercentIndicator(
                width: 330,
                alignment: MainAxisAlignment.center,
                // Set the width
                lineHeight: 16.0, // Set the thickness
                percent: result == null
                    ? 0.0
                    : result!.indays! /
                        result!
                            .mpduration!, // Set a default value (e.g., 0.0) if either value is null
                barRadius: Radius.circular(2),
                backgroundColor: Colors.grey,
                progressColor: primery, // You can use your custom color here
                center: Text(
                  'days : ' +
                      (result == null ? '0' : result!.indays!.toString()),
                  style: TextStyle(color: white),
                ),
                // Text in the center
              ),
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     width: 350,
              //     height: 250,
              //     decoration: BoxDecoration(
              //         color: white,
              //         border: Border.all(width: 1, color: primery),
              //         borderRadius: BorderRadius.circular(8)),
              //     child: Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              //           child: Text('Recent visits',
              //               style: TextStyle(
              //                   fontWeight: FontWeight.bold, fontSize: 16)),
              //         ),
              //         Divider(color: primery, thickness: 2),
              //         Expanded(
              //           child: FutureBuilder(
              //               future: Gethistory(widget!.id!),
              //               builder: (context, snapshot) {
              //                 if (snapshot.hasData) {
              //                   List<Customermodel>? customer = snapshot.data;

              //                   return ListView.builder(
              //                     physics: BouncingScrollPhysics(),
              //                     itemCount: customer!.length,
              //                     itemBuilder: (context, index) {
              //                       return ListTile(
              //                         title: Text(
              //                           'Date :${format.format(DateTime.parse(customer[index].history!))}',
              //                           style: TextStyle(
              //                               fontWeight: FontWeight.bold),
              //                           textAlign: TextAlign.center,
              //                         ),
              //                       );
              //                     },
              //                   );
              //                 } else {
              //                   return Text('loading 🤤');
              //                 }
              //               }),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: primery)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Icon(Icons.fitness_center,
                                  size: 50, color: primery),
                              SizedBox(height: 5),
                              Text(
                                'View Workouts',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Dark,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Button tapped');
                      },
                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: primery)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Icon(
                                Icons.restaurant_menu,
                                color: primery,
                                size: 50,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'view Diet',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Dark,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
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
