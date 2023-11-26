import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';

import '../component/dialogbox.dart';
import '../models/WorkoutModel.dart';
import '../provider/provider.dart';

class ShowWorkouts extends StatefulWidget {
  final int id;

  ShowWorkouts({super.key, required this.id});

  @override
  State<ShowWorkouts> createState() => _ShowWorkoutsState();
}

class _ShowWorkoutsState extends State<ShowWorkouts> {
  late DataProvider _provider;
  List<WorkoutModel>? list;
  WorkoutModel? result;
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
    getUser(widget.id);
  }

  Future<void> getUser(int id) async {
    Response res = await _provider.ShowWorkouts(id);
    if (res.statusCode == 200) {
      list = List<WorkoutModel>.from(
          jsonDecode(res.data!).map((x) => WorkoutModel.fromJson(x)));

      result = list![0];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Workouts', style: TextStyle(color: Dark)),
        actions: [
          IconButton(
              onPressed: () {
                ShowWorkoutinfo(
                    context,
                    result == null ? "0" : result!.wmEndDate!,
                    result == null ? "0" : result!.wmDesc!);
              },
              icon: Icon(
                Icons.info_outline_rounded,
                color: primery,
              ))
        ],
        backgroundColor: white,
        elevation: 0,
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
                  Text('Workouts',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                  Text('Sets',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                  Text('Reps',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold)),
                  Text('Day',
                      style:
                          TextStyle(color: Dark, fontWeight: FontWeight.bold))
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
                future: _provider.ShowWorkouts(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<WorkoutModel> list = List<WorkoutModel>.from(
                        jsonDecode(snapshot.data!.data)
                            .map((x) => WorkoutModel.fromJson(x)),
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
                                          list[index].wType!,
                                          style: TextStyle(color: Dark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.10,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.23,
                                      child: ListTile(
                                        title: Text(
                                          // Add the second type of data from your list here
                                          list[index].wpSets!.toString(),
                                          style: TextStyle(color: Dark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.22,
                                      child: ListTile(
                                        title: Text(
                                          // Add the third type of data from your list here
                                          list[index].wpReps!.toString(),
                                          style: TextStyle(color: Dark),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                      child: ListTile(
                                        title: Text(
                                          // Add the fourth type of data from your list here
                                          list[index].wpDay!.toString(),
                                          style: TextStyle(color: Dark),
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
