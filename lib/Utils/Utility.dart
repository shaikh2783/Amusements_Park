import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iisc_app/Config/Constant/ColorsConstant.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizing/sizing.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

class Utility {
  String validateMobile(String value) {
    String pattern = r'(^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[7896]\d{9}$)';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(value)) {
      return 'Invalid number';
    }
    return "";
  }

  static DateTime stringToDate(String dateStr, String format) {
    DateTime date = DateFormat(format).parse(dateStr);
    return date;
  }

  static String dateToString(DateTime? date, {DateFormat? format}) {
    format ??= DateFormat("dd-MM-yyyy");
    String dateTimeStr = format.format(date ?? DateTime.now());
    return dateTimeStr;
  }

  static String timeToString(DateTime? date, {DateFormat? format}) {
    format ??= DateFormat("h:mma");
    String dateTimeStr = format.format(date ?? DateTime.now());
    return dateTimeStr;
  }

  static String dateCheck(DateTime? date, {DateFormat? format}) {
    format ??= DateFormat("dd-MM-yyyy");
    String dateTimeStr = format.format(date ?? DateTime.now());
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String todayDate = formatter.format(now);

    if (todayDate == dateTimeStr) {
      return "Today";
    } else {
      return dateTimeStr;
    }
  }

  static String convertDateToIsoFormat(String dateString) {
    // Parse the input date string
    final DateFormat inputFormat = DateFormat('MM/dd/yyyy');
    final DateTime parsedDate = inputFormat.parse(dateString);

    // Format the parsed date to the desired format
    final DateFormat outputFormat = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'");
    final String formattedDate = outputFormat.format(parsedDate.toUtc());

    return formattedDate;
  }

  static String getDate(DateTime? date, {DateFormat? format}) {
    format ??= DateFormat("yyyy-MM-dd");
    String dateTimeStr = format.format(date ?? DateTime.now());
    return dateTimeStr;
  }

  String getTodayDate() {
    final DateTime now = DateTime.now().toUtc(); // Ensure UTC timezone
    final String formattedDate = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'")
        .format(now);
    return formattedDate;
  }

  static bool isBeforeDate(String dateStr, String format) {
    DateTime date = DateFormat(format).parse(dateStr);
    final isBefore = date.isBefore(
        DateTime.now().subtract(const Duration(days: 1)));
    return isBefore;
  }

  static bool isBeforeDateFromDate(DateTime dateTime) {
    final isBefore =
    dateTime.isBefore(DateTime.now().subtract(const Duration(days: 1)));
    return isBefore;
  }

  static Future<bool> isInternetAvailable() async {
    bool result = await InternetConnection().hasInternetAccess;
    if (result == false) {
      return false;
    } else {
      return true;
    }
  }

  static String formatNumber(double amount) {
    var f = NumberFormat("#,##,###.00", "en_US");
    var value = f.format(amount);
    return value == ".00" ? "0.00" : value;
  }

  static String formatTimeRangeToAMPM(String startTime, String endTime) {
    final inputFormat = DateFormat('HH:mm:ss');
    final outputFormat = DateFormat('h:mm a');
    final startDateTime = inputFormat.parse(startTime);
    final endDateTime = inputFormat.parse(endTime);
    final formattedStartTime = outputFormat.format(startDateTime);
    final formattedEndTime = outputFormat.format(endDateTime);
    return '$formattedStartTime - $formattedEndTime';
  }

  String getTimeStringFromMinutes(int value, {bool showShortText = false}) {
    final int hour = value ~/ 60;
    final int minutes = value % 60;
    if (hour == 0) {
      return '${minutes.toString().padLeft(2, "0")} mins';
    } else {
      return '${hour.toString().padLeft(2, "0")} ${showShortText
          ? 'h'
          : 'hrs'}, ${minutes.toString().padLeft(2, "0")} ${showShortText
          ? 'm'
          : 'mins'}';
    }
  }

  static String convertTo12HourFormat(String input) {
    List<String> parts = input.split('-');
    if (parts.length != 2) return "Invalid input";
    int hour = int.tryParse(parts[0]) ?? 0;
    int minute = 0;
    DateTime time = DateTime(2023, 1, 1, hour, minute);
    String formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  showAlertForLogout() {
    Future.delayed(Duration.zero, () {
      Get.dialog(
          PopScope(
            canPop: false,
            child: CupertinoAlertDialog(
              title: Text("Alert!", style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 20.fss,
                  color: Colors.black)),
              content: Text("Are you sure? you want to logout",
                  style: TextStyle(fontWeight: FontWeight.w400,
                      fontSize: 16.fss,
                      color: Colors.black87)),
              actions: [
                CupertinoDialogAction(
                  isDefaultAction: true,
                  onPressed: () {
                    Get.back();
                    // RouteManagement().logOut();
                  },
                  child: Text("Yes", style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18.fss,
                      color: ColorsConstant.colorSecondary)),
                ),
                CupertinoDialogAction(
                  isDefaultAction: false,
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("No", style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18.fss,
                      color: ColorsConstant.colorSecondary)),
                ),
              ],
            ),
          ),
          barrierDismissible: false);
    });
  }

  // Future<void> saveBase64File(String base64String, String fileName) async {
  //   try {
  //     if (Platform.isAndroid) {
  //         await saveAndroidFile(base64String, fileName);
  //     }else {
  //       Directory? directory = await getApplicationDocumentsDirectory();
  //       if (!await directory.exists()) {
  //         await directory.create(recursive: true);
  //       }
  //       String filePath = '${directory.path}/$fileName';
  //       // Decode and save Base64 file
  //       List<int> bytes = base64Decode(base64String);
  //       File file = File(filePath);
  //       await file.writeAsBytes(bytes);
  //       if (await file.exists()) {
  //         Share.shareXFiles([XFile(file.path)]);
  //       } else {
  //         if (kDebugMode) {
  //           debugPrint("File not found: $filePath");
  //         }
  //       }
  //       if (kDebugMode) {
  //         debugPrint("File saved at: $filePath");
  //       }
  //     }
  //   } catch (e) {
  //     CustomWidgets().showToast("Download failed try again");
  //     if (kDebugMode) {
  //       debugPrint("Error saving file: $e");
  //     }
  //   }
  // }

  static const platform = MethodChannel("com.example.app/download");

  void sendEmail(String email) async {
    const String subject = "From iisc";
    const String body = "Hello";
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (kDebugMode) {
        debugPrint("Could not launch email app");
      }
    }
  }
  void launchDialPad(String phoneNumber) async {
    final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (kDebugMode) {
        debugPrint("Could not open dialer");
      }
    }
  }
  static Future<File> renameCroppedImage(File originalFile) async {
    Directory appDir = await getApplicationDocumentsDirectory();
    String extension = path.extension(originalFile.path);
    String newFileName = "cropped_image_${DateTime.now().millisecondsSinceEpoch}$extension";
    String newPath = path.join(appDir.path, newFileName);
    // Copy the file to the new path
    File newFile = await originalFile.copy(newPath);
    await originalFile.delete(); // Optional: Delete the original file

    return newFile;
  }
}

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
