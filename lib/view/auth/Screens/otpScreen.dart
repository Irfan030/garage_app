import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/repository/formSubmissionStatus.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/view/auth/authBloc/authBloc.dart';
import 'package:garage_app/view/auth/authBloc/authState.dart';
import 'package:garage_app/view/auth/authRepository.dart';
import 'package:garage_app/widget/authHeader.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/titleWidget.dart';

class OtpScreen extends StatefulWidget {
  final OtpScreenArgument otpScreenArgument;

  const OtpScreen({super.key, required this.otpScreenArgument});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  Authrepository authRepository = Authrepository();
  String otp = "";

  Future<bool> _onWillPop(BuildContext context) async {
    return await showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                title: Text('Are you sure?'),
                content: Text('Do you want to go back?'),
                actions: <Widget>[
                  TextButton(
                    onPressed:
                        () => Navigator.of(context).pop(false), // Stay on page
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed:
                        () => Navigator.of(
                          context,
                        ).pushNamed(RoutePath.login), // Exit app
                    child: Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false; // If user taps outside the dialog, return false (stay on page)
  }

  void resendPassword() async {
    if (widget.otpScreenArgument.from == "signup") {
      try {
        var params = {
          "email": widget.otpScreenArgument.email,
          "firstName": widget.otpScreenArgument.firstName,
          "lastName": widget.otpScreenArgument.lastName,
          "mobileNo": widget.otpScreenArgument.phoneNo,
        };
        var response = await authRepository.signUp(params);
        if (response["code"] == 201 && !response["error"]) {
          AppData.showSnackBar(context, "Otp has been sent successfully");
        } else {
          AppData.showSnackBar(context, response["message"]);
        }
      } catch (e) {
        AppData.showSnackBar(context, e.toString());
      }
    } else {
      try {
        var response = await authRepository.forgotPassword({
          "email": widget.otpScreenArgument.email,
        });

        if (response["code"] == 200 && !response["error"]) {
          AppData.showSnackBar(context, "Otp has been sent successfully");
        } else {
          AppData.showSnackBar(context, response["message"]);
        }
      } catch (e) {
        AppData.showSnackBar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<Authbloc, AuthState>(
      listener: (context, state) {
        final formStatus = state.formSubmissionStatus;
        if (formStatus is SubmissionFailed) {
          AppData.showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.of(context).pushNamed(RoutePath.setPassword);
        }
      },
      child: PopScope(
        canPop: false, // Prevent default back button behavior
        onPopInvokedWithResult: (bool didPop, dynamic result) async {
          if (didPop) return; // If already popped, do nothing

          // Show the confirmation dialog
          final shouldPop = await _onWillPop(context);
          if (shouldPop) {
            Navigator.of(context).pushNamed(RoutePath.login);
          }
        },
        child: Scaffold(
          body: Column(
            children: [
              AuthHeader(
                title: "Enter \nOTP",
                showBackButton: true,
                backbutton: () {
                  _onWillPop(context);
                },
                subtitle: "OTP has been sent to your email ID",
              ),
              SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      DefaultTextInput(
                        hint: "OTP",
                        label: "Enter OTP",
                        onChange: (value) {
                          setState(() {
                            otp = value;
                          });
                        },
                        validator: AppData.otpValidation(otp, false),
                        errorMsg: AppData.otpValidation(otp, true),
                      ),
                      SizedBox(height: 20),
                      submitBtn(),
                      SizedBox(height: 30),
                      GestureDetector(
                        onTap: () {
                          resendPassword();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: TitleWidget(
                            val: "Resend OTP",
                            color: AppColor.mainColor,
                            fontFamily: AppData.openSansMedium,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget submitBtn() {
    return BlocBuilder<Authbloc, AuthState>(
      builder: (context, state) {
        return DefaultButton(
          text: "Confirm",
          loading: state.formSubmissionStatus is FormSubmitting,
          press: () {
            // if (_formKey.currentState!.validate()) {
            //   context.read<Authbloc>().add(AuthVerifyOtp(
            //       email: widget.otpScreenArgument.email, otp: otp));
            // }
          },
        );
      },
    );
  }
}

class OtpScreenArgument {
  String from;
  String email;
  String firstName;
  String lastName;
  String phoneNo;

  OtpScreenArgument({
    required this.from,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phoneNo,
  });
}
