import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';
import '../utils/apiurl.dart';

class UserSettings extends StatefulWidget {
  final int id;
  UserSettings({super.key, required this.id});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  late DataProvider _provider;
  ResultModel? res;
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  Future<void> Updateimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    var result = await _provider.Updateimage(6, pickedFile!);
    if (result.statusCode == 200) {
      res = ResultModel.fromJson(jsonDecode(result.data));
      if (res!.result == '1') {
        print(res!.message);
      } else {
        print(res!.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(color: Dark, fontWeight: FontWeight.bold),
          ),
          backgroundColor: white,
          elevation: 0,
        ),
        backgroundColor: white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Column(children: [
              Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Image.network(
                        '${apiurl}Customer/getImage?id=${6}',
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                        bottom: 2.0,
                        right: 2.0,
                        child: IconButton(
                            onPressed: () {
                              Updateimage();
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: primery,
                            )))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(
                  'name',
                  style: TextStyle(
                      color: Dark, fontWeight: FontWeight.bold, fontSize: 20),
                )),
              )
            ]),
            Divider(
              color: Dark,
              thickness: 2,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Center(
                              child: Icon(
                                Icons.lock_outline,
                                color: Dark,
                                size: 35,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Update Password',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.person_outlined,
                              color: Dark,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Update Username',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8))),
                            child: Icon(
                              Icons.bookmark_add_outlined,
                              color: Dark,
                              size: 35,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text(
                              'Update Details',
                              style: TextStyle(
                                  color: Dark,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios)
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 400,
                height: 40,
                decoration: BoxDecoration(
                    color: error,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Logout',
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20)),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
