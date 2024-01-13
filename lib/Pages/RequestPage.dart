import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/component/buttons.dart';
import 'package:provider/provider.dart';
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
  const _RequestPage({Key? key, required this.id}) : super(key: key);

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

  // ignore: non_constant_identifier_names
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
        physics: const BouncingScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: white,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select a Trainer",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
              FutureBuilder<List<Trainer>>(
                future: getTrainers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('No trainers available');
                  } else {
                    List<DropdownMenuItem<int>> dropdownItems = snapshot.data!
                        .map((trainer) => DropdownMenuItem<int>(
                              value: trainer.trId ?? 0,
                              child: Text(
                                '${trainer.trFname ?? ''} ${trainer.trLname ?? ''}',
                              ),
                            ))
                        .toList();

                    return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: primary,
                                width: 2.0,
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: white),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: DropdownButton<int>(
                              dropdownColor: Colors.white,
                              hint: const Text(
                                'Select a Trainer',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              elevation: 0,
                              iconEnabledColor: primary,
                              iconSize: 30,
                              isExpanded: true,
                              items: dropdownItems,
                              value: selectedTrId,
                              onChanged: (selectedValue) {
                                setState(() {
                                  selectedTrId = selectedValue;
                                });
                              },
                              underline: Container(
                                height: 0,
                              ),
                              style: TextStyle(color: dark),
                            ),
                          ),
                        ));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Requist Diet',
                            style: TextStyle(
                                color: dark, fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Switch(
                          value: dataProvider.isDiet,
                          onChanged: (value) {
                            dataProvider.isDiet = value;
                            if (dataProvider.isDiet == true) {
                              isdiet = 1;
                            } else {
                              isdiet = 0;
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
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Request Workout',
                            style: TextStyle(
                                color: dark, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Switch(
                          value: dataProvider.isworkout,
                          onChanged: (value) {
                            dataProvider.isworkout = value;
                            if (dataProvider.isworkout == true) {
                              isworkout = 1;
                            } else {
                              isworkout = 0;
                            }
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Note",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: dark,
                          offset: Offset.zero,
                        )
                      ],
                      border: Border.all(color: white, width: 2),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      color: offWhite),
                  height: 200,
                  width: 400,
                  child: TextField(
                    controller: descontroller,
                    decoration: const InputDecoration(
                        border: InputBorder.none, hintText: "Note..."),
                    maxLines: null,
                    expands: true,
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () async {
                  await Request();
                },
                child: container_button('Send Request', primary, white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
