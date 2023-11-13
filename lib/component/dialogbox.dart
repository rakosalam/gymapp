import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';

void showMyDialog(BuildContext context, String _barcode) {
  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 200,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: primery),
              color: white),
          child: Card(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 100,
                  width: 300,
                  child: BarcodeWidget(
                      data: _barcode, barcode: Barcode.code128())),
            ),
          )),
        ),
      );
    },
  );

  // Get.defaultDialog(
  //   title: "Dialog Title",
  //   content: Text("This is the dialog content."),
  //   textConfirm: "Confirm",
  //   textCancel: "Cancel",
  //   onConfirm: () {
  //     // Handle confirm button press.
  //     Get.back(); // Close the dialog
  //   },
  //   onCancel: () {
  //     // Handle cancel button press.
  //     Get.back(); // Close the dialog
  //   },
  // );
}
