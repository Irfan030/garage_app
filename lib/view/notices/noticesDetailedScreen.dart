import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/titleWidget.dart';

import 'noticesScreen.dart';

class NoticeDetailScreen extends StatefulWidget {
  final Notice notice;

  const NoticeDetailScreen({super.key, required this.notice});

  @override
  State<NoticeDetailScreen> createState() => _NoticeDetailScreenState();
}

class _NoticeDetailScreenState extends State<NoticeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Notices"),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 12, 12),
          color: AppColor.backgroundColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/svg/notice_icon.svg"),
                    const SizedBox(width: 9.0),
                    TitleWidget(
                      val: 'Admin • ${widget.notice.date}',
                      fontSize: 10,
                      fontFamily: AppData.poppinsRegular,
                      color: AppColor.greyText,
                      letterSpacing: 0,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              TitleWidget(
                val: widget.notice.title,
                fontSize: 17,
                fontFamily: AppData.poppinsSemiBold,
                color: AppColor.blackText,
                letterSpacing: 0,
              ),
              const SizedBox(height: 10),
              const Text(
                'Dear Residents,',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Subject: Upcoming Maintenance Work',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and upkeep of our community, we would like to inform you of upcoming maintenance work.',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Date of Maintenance: 29 Nov 2023',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Time: 08:00 AM',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Location: A Block',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Nature of Work:',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Overhead tank cleaning work.',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Your Cooperation Matters:',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
              ),
              const Text(
                'We kindly request your cooperation during this maintenance period. If there are any specific instructions or precautions you need to be aware of, they will be clearly communicated on the day of the maintenance.',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'We appreciate your understanding and cooperation in ensuring the continued well-being of our community.',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text(
                'Thank you for your attention to this matter.',
                style: TextStyle(fontSize: 14.0),
              ),
              const SizedBox(height: 16.0),
              const Text('Sincerely,', style: TextStyle(fontSize: 14.0)),
              const Text('Property Manager,', style: TextStyle(fontSize: 14.0)),
              const Text('David', style: TextStyle(fontSize: 14.0)),
            ],
          ),
        ),
      ),
    );
  }
}
