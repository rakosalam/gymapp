import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:gymapp/Config/Colorcfg.dart';
import 'package:intl/intl.dart';

final DateFormat format = DateFormat('yyyy-MM-dd');

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
              border: Border.all(color: primary),
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
}

void ShowWorkoutinfo(
    BuildContext context, String startdate, String enddate, String desc) {
  String formattedStartDate = format.format(DateTime.parse(startdate));
  String formatedEndDate = format.format(DateTime.parse(enddate));

  showGeneralDialog(
    barrierDismissible: true,
    barrierLabel: '',
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      return Center(
        child: Container(
          height: 350,
          width: 350,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: primary),
              color: white),
          child: Card(
              child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Start Date:${formattedStartDate}',
                          style: TextStyle(
                              color: dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 15,
                      ),
                      Text('End Date:${formatedEndDate}',
                          style: TextStyle(
                              color: dark,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: 260,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: primary),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(desc,
                            maxLines: 5,
                            style: TextStyle(
                                color: dark,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                      )
                    ],
                  )),
            ),
          )),
        ),
      );
    },
  );
}



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

