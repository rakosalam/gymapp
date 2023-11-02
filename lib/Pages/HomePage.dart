import 'dart:convert';

import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/models/Customermodel.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/ResultModel.dart';
import '../provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key, id});
  int? id;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final String data;

  late DataProvider _provider;
  Customermodel? result;

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
    Getuser(6);
  }

  Future<void> Getuser(int id) async {
    var res = await _provider.ShowcustomerData(id);
    print(res.data);
    if (res.statusCode == 200) {
      result = Customermodel.fromJson(jsonDecode(res.data));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: backgournd,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu, color: primery),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
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
      backgroundColor: backgournd,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
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
                      result == null
                          ? "name"
                          : result!.cusFname! + result!.cusLname!,
                      style: TextStyle(
                          color: Dark,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
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
              SizedBox(height: 30),
              LinearPercentIndicator(
                width: 360,
                alignment: MainAxisAlignment.center,
                // Set the width
                lineHeight: 16.0, // Set the thickness
                percent: (result!.indays != null && result!.mpduration != null)
                    ? result!.indays! / result!.mpduration!
                    : 0.0, // Set a default value (e.g., 0.0) if either value is null
                barRadius: Radius.circular(2),
                backgroundColor: Colors.grey,
                progressColor: primery, // You can use your custom color here
                center: Text(
                  'days :' + result!.indays.toString(),
                  style: TextStyle(color: white),
                ), // Text in the center
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 350,
                  height: 300,
                  decoration: BoxDecoration(
                      color: white,
                      border: Border.all(width: 1, color: primery),
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text('Recent visits',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                      Divider(color: primery, thickness: 2),
                      Expanded(
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: [
                            ListTile(
                              title: Text(
                                'Date :11/11/2023',
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: primery)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/calendar.png',
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'view Workouts',
                                style: TextStyle(
                                    fontSize: 18,
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
                    width: 23,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        print('Button tapped');
                      },
                      child: Container(
                        width: 150,
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: primery)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/diet.png',
                                width: 100,
                                height: 100,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'view Diet',
                                style: TextStyle(
                                    fontSize: 18,
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
          color: backgournd,
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              backgroundColor: backgournd,
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
