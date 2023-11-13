import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/component/buttons.dart';
import 'package:provider/provider.dart';

import '../component/textfield.dart';
import '../models/RequestModel.dart';
import '../models/ResultModel.dart';
import '../models/Trainer.dart';
import '../provider/provider.dart';

class RequestPage extends StatelessWidget {
  final int? id;
  const RequestPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataProvider>(
      key: UniqueKey(),
      create: (context) => DataProvider(),
      child: _RequestPage(id: id), // Pass the id to _RequestPage
    );
  }
}

class _RequestPage extends StatefulWidget {
  final int? id; // Declare id here
  _RequestPage({Key? key, required this.id}) : super(key: key);

  @override
  State<_RequestPage> createState() => _RequestPageState();
}

class _RequestPageState extends State<_RequestPage> {
  late DataProvider _provider;
  final descontroller = TextEditingController();
  int isdiet = 0;
  int isworkout = 0;
  int? selectedTrId;
  RequestModel? _requestModel;
  ResultModel? result;
  @override
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  Future<void> Request() async {
    String desc = descontroller.text;
    _requestModel = RequestModel(
        cusId: widget.id,
        trId: selectedTrId,
        rqDate: DateTime.now(),
        rqDesc: desc,
        rqIsDiet: isdiet,
        rqIsWorkout: isworkout,
        rqId: 0,
        rqStatus: 1);

    var res = await _provider.sendrequest(_requestModel!);
    if (res.statusCode == 200) {
      result = ResultModel.fromJson(jsonDecode(res.data));
      print(result!.result.toString());
    }
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: white,
          child: Column(
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
                                '${trainer.trFname ?? ''} ${trainer.trLname ?? ''}',
                              ), // Check for null before combining names
                            ))
                        .toList();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<int>(
                        dropdownColor: Colors.white,
                        hint: Text('Select a Trainer'),
                        elevation: 0,
                        iconEnabledColor: primery,
                        iconSize: 30,
                        isExpanded: true,
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        items: dropdownItems,
                        value: selectedTrId,
                        onChanged: (selectedValue) {
                          setState(() {
                            selectedTrId = selectedValue;
                          });
                        },
                        underline: Container(
                          // Replace the underline with a border
                          height:
                              0, // Adjust the height of the border as needed
                        ),
                        style: TextStyle(color: Dark), // Customize text color
                      ),
                    );
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Row(
                      children: [
                        Text(
                          'Requist Diet',
                          style: TextStyle(
                              color: Dark, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Switch(
                          value: dataProvider.isDiet,
                          onChanged: (value) {
                            dataProvider.isDiet = value;
                            if (dataProvider.isDiet == true) {
                              isdiet = 1;
                              print(isdiet);
                            } else {
                              isdiet = 0;
                              print(isdiet);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Row(
                      children: [
                        Text(
                          'Request Workout',
                          style: TextStyle(
                              color: Dark, fontWeight: FontWeight.bold),
                        ),
                        Switch(
                          value: dataProvider.isworkout,
                          onChanged: (value) {
                            dataProvider.isworkout = value;
                            if (dataProvider.isworkout == true) {
                              isworkout = 1;
                              print(isworkout);
                            } else {
                              isworkout = 0;
                              print(isworkout);
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: primery, width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  height: 200,
                  width: 400,
                  child: TextField(
                    controller: descontroller,
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              SizedBox(height: 150),
              GestureDetector(
                onTap: () async {
                  await Request();
                },
                child: container_button('Send Request', primery, white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
