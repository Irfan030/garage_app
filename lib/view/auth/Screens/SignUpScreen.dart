import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/repository/formSubmissionStatus.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/view/auth/Screens/otpScreen.dart';
import 'package:garage_app/view/auth/authBloc/authBloc.dart';
import 'package:garage_app/view/auth/authBloc/authEvent.dart';
import 'package:garage_app/view/auth/authBloc/authState.dart';
import 'package:garage_app/widget/authHeader.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/titleWidget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String firstName = "", lastName = "", email = "", phoneNo = "";

  @override
  Widget build(BuildContext context) {
    return BlocListener<Authbloc, AuthState>(
      listener: (context, state) {
        final formStatus = state.formSubmissionStatus;
        if (formStatus is SubmissionFailed) {
          AppData.showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.of(context).pushNamed(
            RoutePath.otpScreen,
            arguments: OtpScreenArgument(
              from: "signup",
              email: email,
              firstName: firstName,
              lastName: lastName,
              phoneNo: phoneNo,
            ),
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              AuthHeader(
                title: "Signup for an\nAccount",
                subtitle: "Register now",
                showBackButton: true,
              ),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(
                            context,
                          ).viewInsets.bottom, // Adjust for keyboard height
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          DefaultTextInput(
                            hint: "Enter First Name",
                            label: "First Name",
                            onChange: (value) {
                              setState(() {
                                firstName = value;
                              });
                            },
                            validator: AppData.nameValidation(firstName),
                            errorMsg: AppData.nameErrorMsg(
                              firstName,
                              "First Name",
                            ),
                          ),
                          SizedBox(height: 20),
                          DefaultTextInput(
                            hint: "Enter Last Name",
                            label: "Last Name",
                            onChange: (value) {
                              setState(() {
                                lastName = value;
                              });
                            },
                            validator: AppData.nameValidation(lastName),
                            errorMsg: AppData.nameErrorMsg(
                              lastName,
                              "Last Name",
                            ),
                          ),
                          SizedBox(height: 20),
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
                          SizedBox(height: 20),
                          DefaultTextInput(
                            hint: "Enter Phone Number",
                            label: "Phone Number",
                            onChange: (value) {
                              setState(() {
                                phoneNo = value;
                              });
                            },
                            validator: AppData.isValidPhoneNo(phoneNo),
                            errorMsg: "Invalid phone number",
                          ),
                          SizedBox(height: 40),
                          submitBtn(),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(RoutePath.login);
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
                                  val: "Login",
                                  color: AppColor.mainColor,
                                  fontFamily: AppData.openSansMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
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
          text: "Send OTP",
          loading: state.formSubmissionStatus is FormSubmitting,
          press: () {
            if (_formKey.currentState!.validate()) {
              context.read<Authbloc>().add(
                AuthSignUp(
                  firstName: firstName,
                  lastName: lastName,
                  email: email,
                  phoneNo: phoneNo,
                ),
              );
            }
          },
        );
      },
    );
  }
}
