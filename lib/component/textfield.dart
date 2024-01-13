import 'package:flutter/material.dart';
import 'package:gymapp/provider/Uiprovider.dart';
import 'package:provider/provider.dart';
import '../Config/Colorcfg.dart';

Widget TextFieldWidget(BuildContext context,
    {TextEditingController? controller,
    bool ispassword = false,
    String? hint,
    IconData icon = Icons.abc}) {
  late final uiprovider = Provider.of<Uiprovider>(context, listen: false);

  GestureDetector gesture(bool b, IconData icon) => GestureDetector(
        onTap: () {
          uiprovider.setshowpassword(!b);
        },
        child: Icon(
          icon,
          color: primary,
          size: 25,
        ),
      );

  return Selector<Uiprovider, bool>(
    selector: (context, uiprovider) =>
        ispassword ? uiprovider.showpassword : false,
    builder: (context, showpassword, child) {
      return TextField(
        controller: controller,
        obscureText: showpassword,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: ispassword
              ? showpassword
                  ? gesture(showpassword, Icons.visibility_rounded)
                  : gesture(showpassword, Icons.visibility_off_rounded)
              : gesture(false, icon),
          hintStyle: TextStyle(color: dark),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: primary),
          ),
        ),
      );
    },
  );
}
