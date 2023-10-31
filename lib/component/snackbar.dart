import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

class MySnackBars {
  static SnackBar getFailureSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Failure',
        message: message,
        contentType: ContentType.failure,
      ),
    );
  }

  static SnackBar successSnackBar(String message) {
    return SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Success',
        message: message,
        contentType: ContentType.success,
      ),
    );
  }

  // /// help
  // static var helpSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Hi There!',
  //     message:
  //         'You need to use this package in the app to uplift your Snackbar Experinece!',
  //     contentType: ContentType.help,
  //   ),
  // );

  // /// success
  // static var successSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Congratulation!',
  //     message:
  //         'You have successfulyy read this message.\nPlease continue working!',
  //     contentType: ContentType.success,
  //   ),
  // );

  // /// warning
  // static var warningSnackBar = SnackBar(
  //   elevation: 0,
  //   behavior: SnackBarBehavior.floating,
  //   backgroundColor: Colors.transparent,
  //   content: AwesomeSnackbarContent(
  //     title: 'Warning!',
  //     message: 'You Have a warning for this message.\nPlease read carefully!',
  //     contentType: ContentType.warning,
  //   ),
  // );
}
