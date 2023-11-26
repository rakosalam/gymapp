import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:provider/provider.dart';

import '../component/buttons.dart';
import '../component/snackbar.dart';
import '../component/textfield.dart';
import '../models/ResultModel.dart';
import '../provider/provider.dart';

class UpdatepasswordPage extends StatefulWidget {
  final int id;

  const UpdatepasswordPage({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdatepasswordPage> createState() => _UpdatepasswordPageState();
}

class _UpdatepasswordPageState extends State<UpdatepasswordPage> {
  final currentpass = TextEditingController();
  final newpass = TextEditingController();
  final confirmpass = TextEditingController();

  late DataProvider _provider;
  ResultModel? result;
  late final SnackBar _snack = MySnackBars.getFailureSnackBar(result!.message!);

  void initState() {
    super.initState();
    _provider = Provider.of<DataProvider>(context, listen: false);
  }

  Future<void> loginfunc() async {
    String _oldpass = currentpass.text;
    String _newpass = newpass.text;
    String _confpass = confirmpass.text;

    var res = await _provider.Updatepassword(2, _oldpass, _newpass);
    if (res.statusCode == 200) {
      result = ResultModel.fromJson(jsonDecode(res.data));

      print(res);
    } else {
      print(res.statusCode.toString() + 'lol nigger');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: white,
        elevation: 0,
        title: Text(
          'Update password',
          style: TextStyle(color: Dark, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: white,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 12),
                        child: TextFieldWidget(
                            currentpass, false, 'current password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 12),
                        child: TextFieldWidget(newpass, false, 'new password'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25.0, vertical: 12),
                        child: TextFieldWidget(
                            confirmpass, false, 'confirm password'),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  loginfunc();
                  print('lol');
                },
                child: container_button('Update password', primery, white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
