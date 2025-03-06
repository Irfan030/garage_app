import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class FeedbackDialog {
  static void showFeedbackDialog(
    BuildContext context,
    Function(Map<String, dynamic>) onSubmit,
  ) {
    double rating = 0;
    bool ratingError = false;
    TextEditingController commentController = TextEditingController();
    bool commentError = false;

    showDialog(
      context: context,
      barrierColor: AppColor.blackColorWithOpacity75,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: TitleWidget(
                              val: "Feedback",
                              color: AppColor.blackText,
                              fontSize: 14,
                              fontFamily: AppData.poppinsMedium,
                              letterSpacing: 0,
                            ),
                          ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // Service Rating Section
                          TitleWidget(
                            val: "Service Rating",
                            color: AppColor.blackText,
                            fontSize: 12,
                            fontFamily: AppData.poppinsMedium,
                            letterSpacing: 0,
                          ),
                          SizedBox(height: getProportionateScreenHeight(5)),

                          // Star Rating
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: List.generate(5, (index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    rating = index + 1.0;
                                    ratingError = false;
                                  });
                                },
                                child: Icon(
                                  index < rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 30,
                                ),
                              );
                            }),
                          ),
                          if (ratingError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TitleWidget(
                                val: 'Please provide a rating.',
                                letterSpacing: 0,
                                fontFamily: AppData.poppinsMedium,
                                fontSize: 10,
                                color: AppColor.red,
                              ),
                            ),
                          SizedBox(height: getProportionateScreenHeight(10)),

                          // Comments Section
                          TitleWidget(
                            val: "Comments",
                            color: AppColor.blackText,
                            fontSize: 12,
                            fontFamily: AppData.poppinsMedium,
                            letterSpacing: 0,
                          ),
                          SizedBox(height: getProportionateScreenHeight(5)),
                          TextField(
                            controller: commentController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Write something...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                commentError = value.trim().isEmpty;
                              });
                            },
                          ),
                          if (commentError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: TitleWidget(
                                val: "Please enter a comment.",
                                letterSpacing: 0,
                                fontFamily: AppData.poppinsMedium,
                                fontSize: 10,
                                color: AppColor.red,
                              ),
                            ),
                          SizedBox(height: getProportionateScreenHeight(20)),

                          // Submit Feedback Button
                          DefaultButton(
                            text: 'Submit Feedback',
                            press: () {
                              setState(() {
                                ratingError = rating == 0;
                                commentError =
                                    commentController.text.trim().isEmpty;
                              });

                              if (!ratingError && !commentError) {
                                // Prepare feedback data
                                final feedbackData = {
                                  "rating": rating,
                                  "comment": commentController.text.trim(),
                                };

                                onSubmit(feedbackData);

                                Navigator.pushReplacementNamed(
                                  context,
                                  RoutePath.successScreen,
                                  arguments: {
                                    'title': 'Feedback',
                                    'subtitle':
                                        'Feedback Submitted Successfully',
                                  },
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: getProportionateScreenHeight(20)),

                    // Close Button
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
