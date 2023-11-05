import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:gymapp/Pages/HomePage.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';
import '../component/snackbar.dart';
import '../provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  late DataProvider _provider;
  ResultModel? result;
  late final SnackBar _snack = MySnackBars.getFailureSnackBar(result!.message!);

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  Future<void> loginfunc() async {
    String uname = usernamecontroller.text;
    String password = passwordcontroller.text;
    var res = await _provider.login(uname, password);
    print(res.data);
    if (res.statusCode == 200) {
      result = ResultModel.fromJson(jsonDecode(res.data));

      print(result!.result);
      // ignore: unrelated_type_equality_checks
      if (result!.result! == '1') {
        print('lol');
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(id: result!.id!);
        }));
      }
    } else {
      print(res.statusCode.toString() + 'lol nigger');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        backgroundColor: white,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ///logo
              Container(
                  height: 150,
                  child: Image(image: AssetImage('assets/barbell.png'))),

              //

              SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: TextField(
                  controller: usernamecontroller,
                  decoration: InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Dark),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primery)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: primery),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextField(
                    controller: passwordcontroller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(color: Dark),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primery),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: primery),
                      ),
                    ),
                  )),

              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  print('nigger');
                  await loginfunc();
                  ScaffoldMessenger.of(context).showSnackBar(_snack);
                },
                child: Container(
                  padding: EdgeInsets.all(25),
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                      color: primery, borderRadius: BorderRadius.circular(8)),
                  child: Center(
                    child: Text(
                      ('Login'),
                      style: TextStyle(
                          color: white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    ),
                  ),
                ),
              )

              ///
              /// button
            ],
          ),
        ),
      ),
    );
  }
}
