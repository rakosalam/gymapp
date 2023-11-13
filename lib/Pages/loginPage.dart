import 'dart:convert';
import 'package:go_router/go_router.dart';
import 'package:gymapp/Pages/main_page.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';
import '../component/buttons.dart';
import '../component/snackbar.dart';
import '../component/textfield.dart';
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
      if (result!.result! == 1) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainPage(id: result!.id!);
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
                child: TextFieldWidget(usernamecontroller, false, 'username'),
              ),

              SizedBox(
                height: 30,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: TextFieldWidget(passwordcontroller, true, 'password')),

              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  await loginfunc();
                  if (result!.result == 0) {
                    ScaffoldMessenger.of(context).showSnackBar(_snack);
                  }
                },
                child: container_button('Log in', primery, white),
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
