import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/titleWidget.dart';

void showConfirmationDialog(
  BuildContext context, {
  required String ticketId,
  required String title,
  required String confirmButtonText,
  required String cancelButtonText,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: AppColor.whiteColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TitleWidget(
                val: title,
                letterSpacing: 0,
                fontFamily: AppData.poppinsMedium,
                fontSize: 14,
                color: AppColor.blackText,
              ),
              SizedBox(height: getProportionateScreenHeight(5)),
              TitleWidget(
                val: "Ticket ID $ticketId",
                letterSpacing: 0,
                fontFamily: AppData.poppinsSemiBold,
                fontSize: 18,
                color: AppColor.blackText,
              ),
              SizedBox(height: getProportionateScreenHeight(30)),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Confirm Button
                  SizedBox(
                    width: SizeConfig.screenWidth / 3.5,
                    child: DefaultButton(
                      press: () {
                        Navigator.pop(context);
                        onConfirm();
                      },
                      borderRadius: 10,
                      text: confirmButtonText,
                    ),
                  ),
                  // Cancel Button
                  SizedBox(
                    width: SizeConfig.screenWidth / 3.5,
                    child: DefaultButton(
                      backgroundColor: AppColor.textFieldHintTextColor,
                      textColor: AppColor.whiteColor,
                      borderRadius: 10,
                      borderColor: AppColor.textFieldHintTextColor,
                      press: () {
                        Navigator.pop(context);
                      },
                      text: cancelButtonText,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
