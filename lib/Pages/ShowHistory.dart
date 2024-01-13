// ignore_for_file: file_names

import 'dart:convert' show jsonDecode;
import 'package:flutter/material.dart';
import 'package:gymapp/models/Customermodel.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import '../Config/Colorcfg.dart';
import '../provider/provider.dart';

class ShowHistory extends StatefulWidget {
  final int id;
  const ShowHistory({super.key, required this.id});

  @override
  State<ShowHistory> createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {
  late DataProvider _provider;
  final DateFormat format = DateFormat('yyyy-MM-dd');
  final DateFormat timeFormat = DateFormat('HH:mm:ss');

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: white,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 70.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date',
                      style:
                          TextStyle(color: dark, fontWeight: FontWeight.bold)),
                  Text('Time',
                      style:
                          TextStyle(color: dark, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: 2,
            ),
            Expanded(
              child: SizedBox(
                child: FutureBuilder(
                  future: _provider.ShowHistory(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active ||
                        snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<Customermodel> list = List<Customermodel>.from(
                          jsonDecode(snapshot.data!.data)
                              .map((x) => Customermodel.fromJson(x)),
                        );

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.40,
                                        child: ListTile(
                                          title: Text(
                                            '${index + 1}: ${format.format(DateTime.parse(list[index].history!))}',
                                            style: TextStyle(color: dark),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.23,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.30,
                                        child: ListTile(
                                          title: Text(
                                            timeFormat
                                                .format(DateTime.parse(
                                                    list[index].history!))
                                                .toString(),
                                            style: TextStyle(color: dark),
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
                        return const Center(child: CircularProgressIndicator());
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
