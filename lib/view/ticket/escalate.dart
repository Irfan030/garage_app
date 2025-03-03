import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/theme/sizeConfig.dart';
import 'package:garage_app/widget/customAppBar.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/titleWidget.dart';

class EscalateTicketScreen extends StatefulWidget {
  final String ticketId;

  const EscalateTicketScreen({super.key, required this.ticketId});

  @override
  State<EscalateTicketScreen> createState() => _EscalateTicketScreenState();
}

class _EscalateTicketScreenState extends State<EscalateTicketScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _tickedIdController = TextEditingController();

  @override
  void dispose() {
    _subjectController.dispose();
    _tickedIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: CustomAppBar(title: "Escalate Ticket"), // Updated app bar title
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Title: Escalation
              TitleWidget(
                val: "Escalation",
                fontSize: 14,
                fontFamily: AppData.poppinsMedium,
                color: AppColor.blackText,
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultTextInput(
                hint: "Type",
                label: 'Ticket ID',
                onChange: (value) {
                  setState(() {
                    _tickedIdController.text = widget.ticketId;
                  });
                },
                validator: AppData.nameValidation(_tickedIdController.text),
                errorMsg: AppData.nameErrorMsg(_tickedIdController.text, "ID"),
              ),
              SizedBox(height: getProportionateScreenHeight(16)),

              DefaultTextInput(
                hint: 'Please describe the issue',
                label: 'Subject',
                onChange: (value) {
                  setState(() {
                    _subjectController.text = value;
                  });
                },
                validator: AppData.nameValidation(_subjectController.text),
                errorMsg: AppData.nameErrorMsg(
                  _subjectController.text,
                  "Subject",
                ),
                maxlineHeight: 5, // Allow multiple lines
              ),

              SizedBox(height: getProportionateScreenHeight(24)),

              // Submit Button
              DefaultButton(
                text: "Submit",
                press: _submitEscalation, // Handle submission
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitEscalation() {
    if (_formKey.currentState!.validate()) {
      // Handle escalation submission
      final subject = _subjectController.text;
      // You can now send the escalation request with the ticket ID and subject
      print("Escalating Ticket ID: ${widget.ticketId}");
      print("Subject: $subject");

      // Optionally, navigate back or show a success message
      Navigator.pop(context);
    }
  }
}
