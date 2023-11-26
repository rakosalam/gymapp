import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/component/dialogbox.dart';
import 'package:gymapp/models/FoodModel.dart';
import 'package:provider/provider.dart';

import '../Config/Colorcfg.dart';
import '../provider/provider.dart';

class ShowDietPage extends StatefulWidget {
  final int id;
  const ShowDietPage({super.key, required this.id});

  @override
  State<ShowDietPage> createState() => _ShowDietPageState();
}

class _ShowDietPageState extends State<ShowDietPage> {
  late DataProvider _provider;
  FoodModel? result;
  List<FoodModel>? list;

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
    getUser(widget.id);
  }

  Future<void> getUser(int id) async {
    Response res = await _provider.ShowFood(id);
    if (res.statusCode == 200) {
      list = List<FoodModel>.from(
          jsonDecode(res.data!).map((x) => FoodModel.fromJson(x)));

      result = list![0];
      print(result!.fmEndDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Diet', style: TextStyle(color: Dark)),
        backgroundColor: white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                ShowWorkoutinfo(
                    context,
                    result == null ? "0" : result!.fmEndDate!,
                    result == null ? "0" : result!.fmDesc!);
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: primery,
              ))
        ],
      ),
      body: Container(
        color: white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Food',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                  Text('Portion',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                  Text('Meal',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            SizedBox(
              height: 400,
              child: FutureBuilder(
                future: _provider.ShowFood(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<FoodModel> list = List<FoodModel>.from(
                        jsonDecode(snapshot.data!.data)
                            .map((x) => FoodModel.fromJson(x)),
                      );

                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.25, // 25% of the screen width
                                      child: ListTile(
                                        title: Text(
                                          list[index].fType!,
                                          style: TextStyle(color: Dark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.12,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.16,
                                      child: ListTile(
                                        title: Text(
                                          // Add the second type of data from your list here
                                          list[index].fPortion!.toString(),
                                          style: TextStyle(color: Dark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.20,
                                      child: ListTile(
                                        title: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            list[index].fMeal!.toString(),
                                            style: TextStyle(color: Dark),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Divider(
                                color: Colors.grey[300],
                                thickness: 2,
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
