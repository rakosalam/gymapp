import 'dart:convert';

import 'package:gymapp/Pages/ShowDietPage.dart';
import 'package:gymapp/Pages/ShowHistory.dart';
import 'package:gymapp/Pages/ShowWorkouts.dart';
import 'package:gymapp/Pages/UserSettings.dart';
import 'package:gymapp/utils/urls.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/models/Customermodel.dart';

import 'package:provider/provider.dart';

import '../Config/ToList.dart';

import '../component/buttons.dart';
import '../component/dialogbox.dart';

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
  var ageAsString;
  int _selectedIndex = 1;
  final Widget _divider = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(thickness: 1, color: Dark),
  );

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);

    print(widget.id);
    if (widget.id == null) {
      return;
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
                      '${homeurl}Customer/getImage?id=${widget.id}',
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
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'age:${result == null ? '0' : result!.age!.toString()}',
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
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'weight: ' +
                                      (result == null
                                          ? '0'
                                          : result!.cusweight!.toString()),
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
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: primery,
                                  borderRadius: BorderRadius.circular(7)),
                              child: Center(
                                child: Text(
                                  'height: ' +
                                      (result == null
                                          ? '0'
                                          : result!.cusheight!.toString()),
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
              GestureDetector(
                onTap: () {
                  showMyDialog(
                      context, result == null ? "00000" : result!.cusCode!);
                },
                child: Container(
                  width: 100,
                  height: 24,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    border: Border.all(color: primery, width: 2),
                  ),
                  child: Center(
                    child: Text(
                      'Show Barcode',
                      style: TextStyle(
                          color: primery, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              _divider,
              Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UserSettings(id: result!.cusId!);
                            }));
                          },
                          child:
                              navbuttons('Settings', Icons.settings_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ShowWorkouts(id: result!.cusId!);
                            }));
                          },
                          child: navbuttons(
                              'Workouts', Icons.fitness_center_outlined),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ShowDietPage(id: result!.cusId!);
                              }));
                            },
                            child: navbuttons(
                                'Diet', Icons.favorite_border_rounded)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              tabBorderRadius: 8,
              backgroundColor: Colors.grey[200]!,
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
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  pagechange(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  pagechange(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      // Handle the first tab if needed
    } else if (_selectedIndex == 1) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HomePage(id: result!.cusId!);
      }));
    } else if (_selectedIndex == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ShowHistory(id: result!.cusId!);
      }));
    }
  }
}
