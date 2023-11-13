import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';

import '../models/Trainer.dart';
import '../provider/provider.dart';

class RequestPage extends StatefulWidget {
  const RequestPage({super.key});

  @override
  State<RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
  Trainer? _trainerModel;

  late DataProvider _provider;

  int isdiet = 0;
  bool diet = false;

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
    getTrainers();
  }

  Future<List<Trainer>> getTrainers() async {
    var result = await _provider.ShowTrainer();

    List<Trainer> trainersList = (jsonDecode(result.data) as List)
        .map((trainerJson) => Trainer.fromJson(trainerJson))
        .toList();

    return trainersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Request Page',
          style: TextStyle(color: Dark),
        ),
        backgroundColor: white,
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FutureBuilder<List<Trainer>>(
              future: getTrainers(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No trainers available');
                } else {
                  List<DropdownMenuItem<int>> dropdownItems = snapshot.data!
                      .map((trainer) => DropdownMenuItem<int>(
                            value: trainer.trId ?? 0,
                            child: Text(
                                '${trainer.trFname ?? ''} ${trainer.trLname ?? ''}'), // Check for null before combining names
                          ))
                      .toList();

                  return DropdownButton<int>(
                    items: dropdownItems,
                    onChanged: (selectedTrid) {
                      print('Selected Trid: $selectedTrid');
                      setState(() {});
                    },
                  );
                }
              },
            ),
            Switch(
              value: diet,
              onChanged: (value) {
                diet = value;
                if (diet == true) {
                  isdiet == 1;
                } else {
                  isdiet == 0;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
