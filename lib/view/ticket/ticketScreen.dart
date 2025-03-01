import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/view/home/ticketCardUI.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String selectedTab = "Open";

  // Dummy data for tickets
  final List<Map<String, String>> dummyJobs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredJobs =
        dummyJobs.where((job) => job['status'] == selectedTab).toList();

    return Scaffold(
      appBar: CustomAppBar(title: "Tickets"),
      body: Column(
        children: [
          Container(
            color: AppColor.whiteColor,
            margin: const EdgeInsets.only(bottom: 5),
            child: TabBar(
              onTap: (value) {
                setState(() {
                  selectedTab = value == 0 ? "Open" : "Closed";
                });
              },
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(width: 5.0, color: AppColor.blueColor),
                insets: EdgeInsets.symmetric(horizontal: 55.0),
              ),
              labelPadding: EdgeInsets.zero,
              tabs: [
                tabBar(
                  selectedTab == "Open",
                  "Open",
                  30,
                  selectedTab == "Open" ? 30 : 40,
                ),
                tabBar(
                  selectedTab == "Closed",
                  "Closed",
                  selectedTab == "Closed" ? 30 : 40,
                  30,
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                buildTicketList(filteredJobs),
                buildTicketList(filteredJobs),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: DefaultButton(
          text: "RAISE TICKET",
          press: () {
            // Add your logic for raising a ticket
          },
        ),
      ),
    );
  }

  Widget buildTicketList(List<Map<String, String>> jobs) {
    return jobs.isEmpty
        ? const Center(child: TitleWidget(val: "No tickets found"))
        : ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return TicketCard();
          },
        );
  }

  Widget tabBar(bool selected, String text, double left, double right) {
    return Container(
      color: AppColor.mainColor,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: selected ? AppColor.backgroundColor : AppColor.unselectedTab,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(left),
            topRight: Radius.circular(right),
          ),
        ),
        child: Tab(
          child: TitleWidget(
            fontFamily: AppData.poppinsMedium,
            val: text,
            color: selected ? AppColor.blueColor : AppColor.grayColor,
          ),
        ),
      ),
    );
  }
}
