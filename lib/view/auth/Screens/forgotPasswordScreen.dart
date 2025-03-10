import 'package:flutter/material.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/view/auth/authRepository.dart';
import 'package:garage_app/widget/authHeader.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/titleWidget.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  final _formKey = GlobalKey<FormState>();
  String email = "";
  bool loading = false;
  Authrepository authrepository = Authrepository();
  void sendOtp() async {
    try {
      setState(() {
        loading = true;
      });
      var response = await authrepository.forgotPassword({"email": email});
      setState(() {
        loading = false;
      });
      if (response["code"] == 200 && !response["error"]) {
        // Navigator.of(context).pushNamed(RoutePath.otpScreen,
        //     arguments: OtpScreenArgument(
        //         from: "forgotPassword",
        //         email: email,
        //         firstName: "",
        //         lastName: "",
        //         phoneNo: ""));
      } else {
        AppData.showSnackBar(context, response["message"]);
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
      AppData.showSnackBar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AuthHeader(
                showBackButton: true,
                title: "Forgot \nPassword",
                subtitle: "Enter your registered email ID",
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    DefaultTextInput(
                      hint: "Enter Email ID",
                      label: "Email ID",
                      onChange: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      validator: AppData.isValidEmail(email),
                      errorMsg: "Invalid email id ",
                    ),
                    SizedBox(height: 40),
                    DefaultButton(
                      text: "Send OTP",
                      loading: loading,
                      press: () {
                        if (_formKey.currentState!.validate()) {
                          sendOtp();
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(RoutePath.signup);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TitleWidget(
                            val: "Already have an account? ",
                            color: Color(0XFF151515),
                            fontFamily: AppData.openSansMedium,
                          ),
                          TitleWidget(
                            val: "Signup",
                            color: AppColor.mainColor,
                            fontFamily: AppData.openSansMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
