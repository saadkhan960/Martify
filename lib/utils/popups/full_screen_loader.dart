import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';

class FullScreenLoader {
  static void show(BuildContext context,
      {String? loadingText, required String lottieAsset}) {
    final dark = MHelperFunctions.isDarkMode(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: dark ? MAppColors.dark : MAppColors.light,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        lottieAsset,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                      ),
                      if (loadingText != null) ...[
                        const SizedBox(height: 20.0),
                        Text(
                          loadingText,
                          style: const TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }
}
