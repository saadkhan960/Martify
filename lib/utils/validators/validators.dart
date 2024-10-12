import 'package:martify/Data/repository.Auth/auth_repository.dart';

class MValidators {
  static String? _userpass;
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    return null;
  }

  static String? changeEmailValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required.';
    }
    // Regular expression for email validation
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final userEmail = AuthenticationRepository.getUserEmail();
    if (!emailRegExp.hasMatch(value)) {
      return 'Invalid email address.';
    }
    if (value == userEmail) {
      return "New email can't be the same as current email.";
    }
    return null;
  }

  static String? validateField(String? value, String? name) {
    if (value == null || value.isEmpty) {
      return '$name is required.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    // Check for minimum password length
    if (value.length < 6) {
      return 'Password must be at least 6 characters long.';
    }
    // Check for uppercase letters
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    // Check for numbers
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    // Check for special characters
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}<>]'))) {
      return 'Password must contain at least one special character.';
    } else {
      _userpass = value;
    }
    return null;
  }

  static String? confirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }

    if (value != _userpass) {
      return 'Confirm password not match with password';
    }
    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required.';
    }
    // Regular expression for 11-digit phone number validation
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required).';
    }
    return null;
  }

  static String? validatePhoneNumberWithCurrent(
      {required String value, required String cuurentPhoneNo}) {
    if (value.isEmpty) {
      return 'Phone number is required.';
    }
    // Regular expression for 11-digit phone number validation
    final phoneRegExp = RegExp(r'^\d{11}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'Invalid phone number format (11 digits required).';
    }
    if (value == cuurentPhoneNo) {
      return "New Phone Number can't be the same as current Phone Number";
    }
    return null;
  }
}
