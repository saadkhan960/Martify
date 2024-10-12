import 'package:flutter/material.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:martify/utils/helpers/helper_function.dart';
import 'package:martify/utils/popups/snackbar_popups.dart';

class MCustomDialog {
  static void showCustomDialog({
    required BuildContext context,
    required String titleText,
    String? contentText,
    String deleteButtonText = "Delete",
    String cancelButtonText = "Cancle",
    required VoidCallback onDelete,
    VoidCallback? onCancle,
  }) {
    final dark = MHelperFunctions.isDarkMode(context);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dark ? MAppColors.dark : MAppColors.light,
          title: Center(
            child: Text(
              titleText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: contentText != null
              ? Text(
                  contentText,
                  textAlign: TextAlign.center,
                )
              : null,
          actions: [
            // Delete button
            TextButton(
              onPressed: onDelete,
              child: Text(
                deleteButtonText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            // Cancel button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MAppColors.primary,
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: onCancle,
              child: Text(cancelButtonText),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  static Future<bool?> cartCustomDialog({
    required BuildContext context,
    required String titleText,
    String? contentText,
    String deleteButtonText = "Remove",
    String cancelButtonText = "Cancel",
  }) {
    final dark = MHelperFunctions.isDarkMode(context);

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dark ? MAppColors.dark : MAppColors.light,
          title: Center(
            child: Text(
              titleText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          content: contentText != null
              ? Text(
                  contentText,
                  textAlign: TextAlign.center,
                )
              : null,
          actions: [
            // Delete button
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Return true for deletion
              },
              child: Text(
                deleteButtonText,
                style: const TextStyle(color: Colors.red),
              ),
            ),
            // Cancel button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MAppColors.primary,
                minimumSize: const Size(0, 40),
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Return false for cancellation
              },
              child: Text(cancelButtonText),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  static void showUnavalibleMessage(BuildContext context) {
    SnackbarService.showSimpleMessage(
        context: context,
        heading: "Comming Soon",
        message: "This option not avalible right now");
  }
}
