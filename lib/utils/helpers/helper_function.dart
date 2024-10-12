import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:martify/Model/cart%20model/cart_item_model.dart';
import 'package:martify/utils/constants/color.dart';
import 'package:random_string/random_string.dart';

class MHelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.orange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Cyan') {
      return Colors.cyan;
    } else if (value == 'Lime') {
      return Colors.lime;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    }
    return null;
  }

  static void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showAlert(String title, String message, BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('0K'),
                ),
              ]);
        });
  }

  static void simpleNavigation(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void strictNavigation(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static void strictAnimationNavigation(BuildContext context, Widget screen) {
    // print("Context: $context, Screen: $screen");
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeIn;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(
            curve: curve,
          ));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
    );
  }

  static void copyTextWithSnackBarMessage(
      {required String text, required context}) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        width: 220,
        content: const Text('Text copied to clipboard'),
        behavior: SnackBarBehavior.floating, // Makes the SnackBar "float"
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Round edges
        ),
        // margin: EdgeInsets.only(
        //   bottom: 20.0, // Margin from the bottom
        //   left: 20.0, // Margin from the left side
        //   right: 20.0, // Margin from the right side
        // ),
        backgroundColor:
            MAppColors.primary, // Background color for the SnackBar
      ),
    );
  }

  static void simpleCopyText({required String text}) {
    Clipboard.setData(ClipboardData(text: text));
  }

  static void mostStrictAnimationNavigation(
      BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeIn;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(
            curve: curve,
          ));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
      ),
      (Route<dynamic> route) => false,
    );
  }

  static void simpleAnimationNavigation(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeIn;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double screenwidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedlList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedlList.add(Row(children: rowChildren));
    }
    return wrappedlList;
  }

  static String generateUniqueKey(String productId, String size, String color) {
    return '$productId-$size-$color';
  }

  static double calculateTotalAmount(Map<String, CartItemModel> items) {
    double totalAmount = 0.0;

    // Iterate over each item in the list
    for (var item in items.values) {
      totalAmount += item.price * item.quantity; // Multiply price by quantity
    }

    return totalAmount;
  }

  static String randomOrderNumber() {
    String randomNumber = randomNumeric(5);

    // Format the ID string as "MT-006712"
    String idString = 'MT-${randomNumber.padLeft(5, '0')}';
    return idString;
  }
}
