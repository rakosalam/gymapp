import 'dart:convert';
import 'dart:math';
import 'package:gymapp/Pages/main_page.dart';
import 'package:gymapp/models/ResultModel.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';
import '../component/buttons.dart';
import '../component/snackbar.dart';
import '../component/textfield.dart';
import '../provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernamecontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

  late DataProvider _provider;
  ResultModel? result;
  late final SnackBar _snack = MySnackBars.getFailureSnackBar(result!.message!);

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  Future<void> loginfunc() async {
    String uname = usernamecontroller.text;
    String password = passwordcontroller.text;
    var res = await _provider.login(uname, password);
    // ignore: avoid_print
    print(res.data);
    if (res.statusCode == 200) {
      result = ResultModel.fromJson(jsonDecode(res.data));

      if (result!.result! == 1) {
        // ignore: use_build_context_synchronously
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MainPage(id: result!.id!);
        }));
      }
    } else {
      // ignore: avoid_print
      print(res.statusCode.toString());
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
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),

                  ///logo
                  const SizedBox(
                    height: 150,
                    child: Image(image: AssetImage('assets/logo.png')),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        top: 60, left: 25, right: 25, bottom: 10),
                    child: TextFieldWidget(context,
                        controller: usernamecontroller,
                        ispassword: false,
                        hint: 'username',
                        icon: Icons.person_rounded),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 10.0,
                    ),
                    child: TextFieldWidget(context,
                        controller: passwordcontroller,
                        ispassword: true,
                        hint: 'password'),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: GestureDetector(
                        onTap: () async {
                          await loginfunc();
                          if (result!.result == 0) {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(_snack);
                          }
                        },
                        child: container_button('Log in', primery, white),
                      ),
                    ),
                  ),

                  ///
                  /// button
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
