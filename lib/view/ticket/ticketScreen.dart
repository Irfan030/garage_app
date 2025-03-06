import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/view/home/ticketCardUI.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/loader.dart';
import 'package:garage_app/widget/titleWidget.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  String selectedTab = "Open";
  bool isLoadingOpen = true;
  bool isLoadingClosed = true;
  List<Map<String, String>> openJobs = [];
  List<Map<String, String>> closedJobs = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchOpenTickets();
    _fetchClosedTickets();
    _tabController?.addListener(() {
      setState(() {
        selectedTab = _tabController?.index == 0 ? "Open" : "Closed";
      });
    });
  }

  Future<void> _fetchOpenTickets() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setState(() {
      openJobs = [
        {
          "issue": "Power Issue",
          "status": "Open",
          "category": "Pump",
          "mainCategory": "Building Structure",
          "callType": "Pro-Active",
          "equipment": "Pump",
          "component": "Component 1",
          "priority": "Urgent",
          "ticketId": "0001",
          "assessment": "Pump Assessment",
          "date": "30 Nov 2023",
          "assignedTo": "Yet to assigned",
        },
      ];
      isLoadingOpen = false;
    });
  }

  Future<void> _fetchClosedTickets() async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate API call
    setState(() {
      closedJobs = [
        {
          "issue": "Power Issue",
          "status": "Completed",
          "category": "Pump",
          "mainCategory": "Building Structure",
          "callType": "Pro-Active",
          "equipment": "Pump",
          "component": "Component 1",
          "priority": "Urgent",
          "ticketId": "0002",
          "assessment": "Pump Assessment",
          "assessmentClosed": "Pump Assessment done ",

          "date": "30 Nov 2023",
          "assignedTo": "Samuel Wilson",
        },
        {
          "issue": "Power Issue",
          "status": "Completed",
          "category": "Pump",
          "mainCategory": "Building Structure",
          "callType": "Pro-Active",
          "equipment": "Pump",
          "component": "Component 1",
          "priority": "Urgent",
          "ticketId": "0003",
          "assessment": "Pump Assessment",
          "assessmentClosed": "Pump Assessment done ",

          "date": "30 Nov 2023",
          "assignedTo": "Samuel Wilson",
        },
      ];
      isLoadingClosed = false;
    });
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(title: "Tickets"),
      body: Column(
        children: [
          // TabBar Section
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
              physics: const NeverScrollableScrollPhysics(), // Disable swipe
              children: [
                isLoadingOpen
                    ? _buildLoading()
                    : buildTicketList(openJobs, "Open Tickets"),
                isLoadingClosed
                    ? _buildLoading()
                    : buildTicketList(closedJobs, "Closed Tickets"),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton:
          selectedTab == "Open"
              ? Container(
                width: SizeConfig.screenWidth / 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(23),
                  color: AppColor.mainColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadow,
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RoutePath.editTicket,
                      arguments: {'isEditMode': false},
                    );
                  },
                  label: TitleWidget(
                    val: "RAISE TICKET",
                    fontSize: 12,
                    letterSpacing: 0,
                    color: AppColor.whiteColor,
                    fontFamily: AppData.poppinsMedium,
                  ),
                ),
              )
              : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildLoading() {
    return const Center(child: Loader());
  }

  Widget buildTicketList(List<Map<String, String>> jobs, String title) {
    return jobs.isEmpty
        ? Container(
          color: AppColor.backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                "assets/images/svg/no_tickets_icon.svg",
                width: getProportionateScreenHeight(40),
                height: getProportionateScreenHeight(40),
              ),
              const SizedBox(height: 10),
              TitleWidget(
                val: "You haven't raised any tickets.",
                fontSize: 12,
                letterSpacing: 0,
                fontFamily: AppData.poppinsRegular,
                color: AppColor.greyTextColor,
              ),
            ],
          ),
        )
        : Container(
          color: AppColor.backgroundColor,
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 0),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                child: TitleWidget(
                  val: title,
                  letterSpacing: 0,
                  fontFamily: AppData.poppinsMedium,
                  fontSize: 14,
                  color: AppColor.blackText,
                ),
              ),
              ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 5,
                ),
                physics:
                    const NeverScrollableScrollPhysics(), // Disable inner ListView scroll
                shrinkWrap: true,
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ), // Add margin between cards
                    child: TicketCard(
                      issue: job["issue"]!,
                      status: job["status"]!,
                      category: job["category"]!,
                      priority: job["priority"]!,
                      ticketId: job["ticketId"]!,
                      assessment: job["assessment"]!,
                      date: job["date"]!,
                      assignedTo: job["assignedTo"]!,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          RoutePath.ticketDetail,
                          arguments: job,
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
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
