import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/titleWidget.dart';

class NoticesScreen extends StatefulWidget {
  const NoticesScreen({super.key});

  @override
  State<NoticesScreen> createState() => _NoticesScreenState();
}

class Notice {
  final String title;
  final String date;
  final String content;

  Notice({required this.title, required this.date, required this.content});
}

class _NoticesScreenState extends State<NoticesScreen> {
  final List<Notice> notices = [
    Notice(
      title: 'Minutes of the Meeting held on 26-11-2021',
      date: 'Today, 01:33 PM',
      content:
          'We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and comfort of the residents...',
    ),
    Notice(
      title: 'Minutes of the Meeting held on 26-11-2022',
      date: 'Today, 02:33 PM',
      content:
          'We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and comfort of the residents...',
    ),
    Notice(
      title: 'Minutes of the Meeting held on 26-11-2023',
      date: 'Today, 03:33 PM',
      content:
          'We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and comfort of the residents...',
    ),
    Notice(
      title: 'Minutes of the Meeting held on 26-11-2024',
      date: 'Today, 04:33 PM',
      content:
          'We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and comfort of the residents...',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notices"),
      body: SingleChildScrollView(
        child: Container(
          color: AppColor.backgroundColor,
          child: Column(
            children: [
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: notices.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RoutePath.noticesDetailedScreen,
                        arguments: notices[index],
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 16,
                      ),
                      padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
                      decoration: BoxDecoration(
                        color: AppColor.whiteColor,
                        border: Border.all(
                          color: AppColor.cartItemBorder,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.blueColorWithOpacity10,
                            blurRadius: 6,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                "assets/images/svg/notice_icon.svg",
                              ),

                              const SizedBox(width: 7.0),
                              TitleWidget(
                                val: 'Admin • ${notices[index].date}',
                                fontSize: 10,
                                fontFamily: AppData.poppinsRegular,
                                color: AppColor.greyText,
                                letterSpacing: 0,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          TitleWidget(
                            val: notices[index].title,
                            fontSize: 13,
                            fontFamily: AppData.poppinsSemiBold,
                            color: AppColor.blackText,
                            letterSpacing: 0,
                          ),
                          const SizedBox(height: 8),
                          TitleWidget(
                            val: notices[index].content,
                            fontSize: 12,
                            fontFamily: AppData.poppinsRegular,
                            color: AppColor.blackColor,
                            letterSpacing: 0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
