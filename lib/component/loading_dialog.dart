import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showLoadingScreen(BuildContext context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Please Waite"),
          content: Lottie.asset("assets/loading_gray.json"),
        );
      });
}
