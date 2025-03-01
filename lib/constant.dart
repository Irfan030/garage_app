import 'package:flutter/material.dart';

class AppData {
  static String AppName = "Firebridge Property Management";
  static String session = "app-session";
  static String userId = "userid";
  static String role = "role";
  static String firstName = "firstName";
  static String lastName = "lastName";
  static String domainname = "gomotires.com";
  static String platform = "mobile";

  // font
  static String openSansRegular = "OpenSansRegular";
  static String openSansMedium = "OpenSansMedium";
  static String openSansBold = "OpenSansBold";
  static String khandBold = "KhandBold";
  static String openSansSemiBold = "OpenSansSemibold";

  static String poppinsRegular = "PoppinsRegular";
  static String poppinsSemiBold = "PoppinsSemiBold";
  static String poppinsMedium = "PoppinsMedium";
  static String poppinsItalic = "PoppinsItalic";

  static String cartId = "";
  // Image base url
  static String imageBaseUrl = "https://gomobile.firebridge.co.za/";

  // Set user id and role
  static String userIdValue = "";
  static String roleValue = "";

  static showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static bool isPasswordValid(String password) {
    return !RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool isValidEmail(String email) {
    return !RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    ).hasMatch(email.trim());
  }

  static bool isValidPhoneNo(String phoneNo) {
    return !RegExp(r'^\d{10}$').hasMatch(phoneNo);
  }

  static isEmptyCheck(String val) {
    if (val.isEmpty) {
      return true;
    }
    return false;
  }

  static isEmptyErrorMsg(String val, String name) {
    if (val.isEmpty) {
      return "$name is required";
    }
    return "";
  }

  static nameValidation(String val) {
    if (val.isEmpty) {
      return true;
    } else if (val.length > 25) {
      return true;
    }
    return false;
  }

  static nameErrorMsg(String val, String name) {
    if (val.isEmpty) {
      return "$name is required";
    } else if (val.length > 25) {
      return "${name}must be less than 25 character";
    }
    return "";
  }

  static bool lengthValidation(String val, int maxChar) {
    if (val.isEmpty) {
      return true;
    } else if (val.length > maxChar) {
      return true;
    }
    return false;
  }

  // Address Validation
  static bool addressValidation(String val) {
    if (val.isEmpty) {
      return true;
    } else if (val.length > 25) {
      return true;
    }
    return false;
  }

  static String addressErrorMsg(String val) {
    if (val.isEmpty) {
      return "Address is required";
    } else if (val.length > 25) {
      return "Address must be less than 25 character";
    }
    return "";
  }

  static String invalidErrorMsg(String errorName) {
    return "Please enter a valid $errorName";
    // if (val.isEmpty) {
    //   return "Address is required";
    // } else if (val.length > 25) {
    //   return "Address must be less than 25 character";
    // }
    // return "";
  }

  static bool phoneValidation(String val) {
    final phoneRegex = RegExp(r'^\+?1?\d{10}$');
    if (!phoneRegex.hasMatch(val)) {
      return true;
    }
    return false;
  }

  static String phoneErrorMsg(String val) {
    if (val.isEmpty) {
      return "Phone number is required";
    } else if (!RegExp(r'^\+?1?\d{10}$').hasMatch(val)) {
      return "Enter a valid 10-digit US phone number";
    }
    return "";
  }

  static bool zipCodeValidation(String val) {
    final zipCodeRegex = RegExp(r'^\d{5}$'); // Matches a 5-digit number
    if (!zipCodeRegex.hasMatch(val)) {
      return true;
    }
    return false;
  }

  static String zipCodeErrorMsg(String val) {
    if (val.isEmpty) {
      return "ZIP code is required";
    } else if (!RegExp(r'^\d{5}$').hasMatch(val)) {
      return "Enter a valid 5-digit ZIP code";
    }
    return "";
  }

  static descriptionValidation(String val) {
    if (val.isEmpty) {
      return true;
    } else if (val.length > 150) {
      return true;
    }
    return false;
  }

  static otpValidation(String val, bool isMesssage) {
    if (val.isEmpty) {
      return isMesssage ? "Otp is required" : true;
    } else if (!RegExp(r'^\d{4}$').hasMatch(val)) {
      return isMesssage ? "Invalid otp" : true;
    }
    return isMesssage ? "" : false;
  }

  static void showSnackBarShow(
    BuildContext context,
    String message, {
    Color backgroundColor = Colors.green,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: Colors.white)),
        backgroundColor: backgroundColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
