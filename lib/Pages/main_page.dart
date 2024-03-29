import 'dart:convert';

import 'package:get/get.dart';
import 'package:gymapp/Pages/RequestPage.dart';
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
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:provider/provider.dart';

import '../Config/ToList.dart';

import '../component/buttons.dart';
import '../component/dialogbox.dart';

import '../provider/provider.dart';

class MainPage extends StatefulWidget {
  final int id;
  const MainPage({super.key, required this.id});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController pageController = PageController(initialPage: 1);
  int selectedTab = 1;
  late final String data;
  final DateFormat format = DateFormat('yyyy-MM-dd');
  late DataProvider _provider;
  Customermodel? result;
  double progress = 0.9;
  Color progresscolor = success;

  final Widget _divider = Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Divider(thickness: 1, color: Dark),
  );

  @override
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

  Color progcolor(double P) {
    if (P <= 1.0 && P >= 0.5) {
      return success;
    } else if (P <= 0.5 && P >= 0.3) {
      return Warning;
    } else if (P <= 0.3 && P >= 0.0) {
      return error;
    }
    return error;
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
          selectedTab == 1
              ? 'Homepage'
              : selectedTab == 2
                  ? "History"
                  : "Request",
          style: TextStyle(color: Dark),
        ),
      ),
      backgroundColor: white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  ShowHistory(id: widget.id),
                  HomePage(context),
                  RequestPage(id: widget.id)
                ],
              ),
            ),
          ],
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
              selectedIndex: 1,
              onTabChange: (tab) {
                switch (tab) {
                  case 0:
                    pageController.jumpToPage(2);
                  case 1:
                    pageController.jumpToPage(0);
                  case 2:
                    pageController.jumpToPage(1);
                }
                setState(() {
                  selectedTab = tab;
                });
              },
              tabBorderRadius: 8,
              backgroundColor: Colors.grey[200]!,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: white,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
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

  Column HomePage(BuildContext context) {
    return Column(
      children: [
        Column(children: [
          CircularPercentIndicator(
            radius: 65.0,
            animation: true,
            animationDuration: 100,
            lineWidth: 8.0,
            percent: progress,
            progressColor: progcolor(progress),
            center: ClipOval(
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
                        color: Dark, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 12, 8),
                      child: Container(
                        width: 85,
                        height: 30,
                        decoration: BoxDecoration(
                            color: primery,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            result == null ? "Age" : "Age: ${result!.age}",
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
                        width: 85,
                        height: 30,
                        decoration: BoxDecoration(
                            color: primery,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            result == null
                                ? "Weight"
                                : "weight: ${result!.cusweight}",
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
                        width: 85,
                        height: 30,
                        decoration: BoxDecoration(
                            color: primery,
                            borderRadius: BorderRadius.circular(7)),
                        child: Center(
                          child: Text(
                            result == null
                                ? "Height"
                                : "Height: ${result!.cusheight}",
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

        const SizedBox(height: 10),

        GestureDetector(
          onTap: () {
            showMyDialog(context, result == null ? "00000" : result!.cusCode!);
          },
          child: Container(
            width: 120,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              border: Border.all(color: primery, width: 2),
            ),
            child: Center(
              child: Text(
                'Show Barcode',
                style: TextStyle(color: primery, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

        const SizedBox(height: 10),
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
                    child: navbuttons('Settings', Icons.settings_outlined),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowWorkouts(id: widget.id),
                          )),
                      child: navbuttons(
                          'Workouts', Icons.fitness_center_outlined)),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ShowDietPage(id: widget.id),
                          )),
                      child: navbuttons('Diet', Icons.favorite_border_rounded)),
                ),
              ],
            ),
          ),
        ),

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
    );
  }
}
