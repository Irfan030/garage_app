import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/view/home/ticketCardUI.dart';
import 'package:garage_app/widget/homeAppBar.dart';
import 'package:garage_app/widget/textButtonIcon.dart';
import 'package:garage_app/widget/textbutton.dart';
import 'package:garage_app/widget/titleWidget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> ticketsData = [
    {
      "issue": "Power Issue",
      "status": "Pending",
      "category": "Pump",
      "priority": "Urgent",
      "ticketId": "0001",
      "assessment": "Pump Assessment",
      "date": "30 Nov 2023",
      "assignedTo": "Yet to assigned",
    },
  ];
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  // String? scannedData;
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _onWillPop(context);
        }
      },
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,

        appBar: HomeAppBar(appBar: AppBar()),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: AppColor.backgroundColor,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: getProportionateScreenHeight(5)),
                      _buildNoticeSection(),
                      _buildOpenTicketsSection(),
                      ticketsData.isEmpty
                          ? Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 50),
                              child: TitleWidget(
                                val: "You haven't raised any tickets.",
                              ),
                            ),
                          )
                          : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 5,
                            ),
                            itemCount: ticketsData.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              final ticket = ticketsData[index];
                              return TicketCard(
                                issue: ticket["issue"]!,
                                status: ticket["status"]!,
                                category: ticket["category"]!,
                                priority: ticket["priority"]!,
                                ticketId: ticket["ticketId"]!,
                                assessment: ticket["assessment"]!,
                                date: ticket["date"]!,
                                assignedTo: ticket["assignedTo"]!,
                                onTap: () {},
                              );
                            },
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: Container(
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
              // _showRaiseTicketDialog(context);

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
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  // void _showRaiseTicketDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     barrierColor: AppColor.blackColorWithOpacity75, // Blurred background
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         backgroundColor: Colors.transparent,
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur effect
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               Container(
  //                 width: MediaQuery.of(context).size.width * 0.8,
  //                 padding: const EdgeInsets.all(20),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.circular(15),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: AppColor.blackColorWithOpacity16,
  //                       blurRadius: 6,
  //                       offset: const Offset(0, 3),
  //                     ),
  //                   ],
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // Scanner Box
  //                     Container(
  //                       height: 200, // Adjust height as needed
  //                       decoration: BoxDecoration(
  //                         color: Colors.grey[200],
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                       child: QRView(
  //                         key: qrKey,
  //                         onQRViewCreated: _onQRViewCreated,
  //                       ),
  //                     ),
  //                     SizedBox(height: 20),
  //                     // Scan QR Button
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         if (scannedData != null) {
  //                           Navigator.pop(context); // Close the dialog
  //                           Navigator.pushNamed(
  //                             context,
  //                             RoutePath.editTicket,
  //                             arguments: {
  //                               'isEditMode': false,
  //                               'data': scannedData,
  //                             },
  //                           );
  //                         } else {
  //                           ScaffoldMessenger.of(context).showSnackBar(
  //                             SnackBar(
  //                               content: Text('No QR code scanned yet!'),
  //                             ),
  //                           );
  //                         }
  //                       },
  //                       child: Text("Scan QR"),
  //                     ),
  //                     SizedBox(height: 10),
  //                     // Add Manual Button
  //                     ElevatedButton(
  //                       onPressed: () {
  //                         Navigator.pop(context); // Close the dialog
  //                         Navigator.pushNamed(
  //                           context,
  //                           RoutePath.editTicket,
  //                           arguments: {'isEditMode': false},
  //                         );
  //                       },
  //                       child: Text("Add Manual"),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // void _onQRViewCreated(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) {
  //     setState(() {
  //       scannedData = scanData.code; // Store the scanned data
  //     });
  //     controller.pauseCamera(); // Pause the camera after scanning
  //   });
  // }

  Widget _buildNoticeSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColor.blueColorWithOpacity10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: const BoxDecoration(
                      color: AppColor.whiteColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/svg/notices_icon.svg',
                        width: 17,
                        height: 17,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        val: "Notices",
                        fontSize: 13,
                        fontFamily: AppData.poppinsMedium,
                        color: AppColor.blackText,
                      ),
                      TitleWidget(
                        val: "Admin • Oct 27, Fri",
                        fontSize: 10,
                        fontFamily: AppData.poppinsRegular,
                        color: AppColor.grayColor,
                      ),
                    ],
                  ),
                ],
              ),
              TextIconButtonWidget(
                text: 'View all',
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutePath.noticesScreen);
                },
                iconSize: 20,
              ),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(13)),
          Container(
            decoration: BoxDecoration(
              color: AppColor.whiteColor,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleWidget(
                  letterSpacing: 0,
                  val: "Minutes of the Meeting held on 26-11-2023",
                  fontSize: 13,
                  fontFamily: AppData.poppinsSemiBold,
                  color: AppColor.blackText,
                ),
                SizedBox(height: getProportionateScreenHeight(7)),
                TitleWidget(
                  letterSpacing: 0,
                  val:
                      "Dear Staffs, Subject: Upcoming Maintenance Work. We hope this notice finds you well. As part of our ongoing commitment to ensuring the safety and upkeep of our community, we would...",
                  fontSize: 12,
                  fontFamily: AppData.poppinsRegular,
                  color: AppColor.blackColor,
                ),
                SizedBox(height: getProportionateScreenHeight(7)),
                Center(
                  child: TextButtonWidget(
                    text: 'Read more',
                    fontSize: 12,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenTicketsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TitleWidget(
            val: "Open Tickets",
            fontSize: 14,
            letterSpacing: 0,
            fontFamily: AppData.poppinsMedium,
            color: AppColor.blackText,
          ),
          TextIconButtonWidget(
            text: 'View all',
            onPressed: () {
              Navigator.of(context).pushNamed(RoutePath.ticketScreen);
            },
            iconSize: 20,
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Exit App'),
                content: const Text('Are you sure you want to close the app?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Yes'),
                  ),
                ],
              ),
        )) ??
        false;
  }
}
