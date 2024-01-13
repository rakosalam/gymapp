import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:gymapp/Pages/loginPage.dart';
import 'package:gymapp/Pages/updatepassword.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../component/buttons.dart';
import '../component/snackbar.dart';
import '../models/Customermodel.dart';
import '../provider/provider.dart';
import '../utils/urls.dart';

class UserSettings extends StatefulWidget {
  final int id;
  const UserSettings({super.key, required this.id});

  @override
  State<UserSettings> createState() => _UserSettingsState();
}

class _UserSettingsState extends State<UserSettings> {
  late DataProvider _provider;
  ResultModel? res;
  Customermodel? result;

  SnackBar _snack = MySnackBars.getFailureSnackBar('lol');
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);

    Getuser(widget.id);
  }

  Future<void> Getuser(int id) async {
    var res = await _provider.ShowcustomerData(id);
    print(res.data);
    if (res.statusCode == 200) {
      result = Customermodel.fromJson(jsonDecode(res.data));
      setState(() {});
    }
  }

  // ignore: non_constant_identifier_names
  Future<void> Updateimage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    var result = await _provider.Updateimage(widget.id, pickedFile!);
    if (result.statusCode == 200) {
      res = ResultModel.fromJson(jsonDecode(result.data));
      if (res!.result == 1) {
        _snack = MySnackBars.getFailureSnackBar(res!.message!);
      } else {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: primary,
            ),
          ),
          centerTitle: true,
          title: Text(
            'Settings',
            style: TextStyle(color: dark, fontWeight: FontWeight.bold),
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
                child: CircleAvatar(
                  radius: 68.0,
                  // backgroundImage: NetworkImage('https://via.placeholder.com/300'),
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          '${homeurl}Customer/getImage?id=${widget.id}',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          left: 0,
                          height: 33,
                          child: GestureDetector(
                            onTap: () {
                              Updateimage();
                            },
                            child: Container(
                              height: 20,
                              width: 30,
                              color: Color.fromRGBO(0, 0, 0, .74),
                              child: Center(
                                child: Icon(Icons.photo_camera,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                    child: Text(
                  result == null
                      ? "name"
                      : '${result!.cusFname!} ${result!.cusLname!}',
                  style: TextStyle(
                      color: dark, fontWeight: FontWeight.bold, fontSize: 20),
                )),
              )
            ]),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Divider(
                color: Colors.grey[300],
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return UpdatepasswordPage(id: result!.cusId!);
                    }));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child:
                            navbuttons('Update Password', Icons.lock_outline),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: navbuttons('Update User', Icons.person_outline),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: navbuttons('Details', Icons.edit_outlined),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                },
                child: Container(
                  width: 400,
                  height: 40,
                  decoration: BoxDecoration(
                      color: error,
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Logout',
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20)),
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
