import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/sharedpreference.dart';
import 'package:garage_app/theme/colors.dart';
import 'package:garage_app/view/auth/authBloc/authBloc.dart';
import 'package:garage_app/view/auth/authBloc/authState.dart';
import 'package:garage_app/view/auth/authRepository.dart';
import 'package:garage_app/widget/authHeader.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/defaultTextInput.dart';
import 'package:garage_app/widget/passwordInput.dart';
import 'package:garage_app/widget/titleWidget.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String email = "", password = "";
  bool loader = false;
  Authrepository authRepository = Authrepository();

  @override
  void initState() {
    super.initState();
    cameraPermissionStatus();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColor.backgroundColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const AuthHeader(
                  title: "Login to your\nAccount ",
                  subtitle: "Welcome back!",
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
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
                      const SizedBox(height: 20),
                      PasswordInput(
                        hint: "Password",
                        label: "Enter Password",
                        onChange: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: AppData.isEmptyCheck(password),
                        errorMsg: AppData.isEmptyErrorMsg(password, "Password"),
                      ),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(
                            context,
                          ).pushNamed(RoutePath.forgotPassword);
                        },
                        child: Container(
                          alignment: Alignment.topRight,
                          child: TitleWidget(
                            val: "Forgot Password",
                            color: AppColor.mainColor,
                            fontFamily: AppData.openSansMedium,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      submitBtn(),
                      const SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(RoutePath.signup);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TitleWidget(
                              val: "Doesn't have an account? ",
                              color: AppColor.blackText,
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
      ),
    );
  }

  Widget submitBtn() {
    return BlocBuilder<Authbloc, AuthState>(
      builder: (context, state) {
        return DefaultButton(
          text: "Login",

          loading: loader,
          press: () {
            if (_formKey.currentState!.validate()) {
              login();
            }
          },
        );
      },
    );
  }

  void cameraPermissionStatus() async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      photoPermissionStatus();
    } else {
      photoPermissionStatus();
    }
  }

  void photoPermissionStatus() async {
    final status = await Permission.photos.request();
    if (status.isGranted) {
      videoPermissionStatus();
    } else {
      videoPermissionStatus();
    }
  }

  void videoPermissionStatus() async {
    final status = await Permission.videos.request();
    if (status.isGranted) {
    } else {}
  }

  void login() async {
    setState(() {
      loader = true;
    });

    var params = {
      "email": email,
      "password": password,
      "persistentLogin": true,
    };

    var response = await authRepository.login(params);
    if (response.data["code"] == 200 && !response.data["error"]) {
      await SharedPreference.addStringToSF(
        AppData.session,
        response.headers['Authorization']?[0],
      );
      await SharedPreference.addStringToSF(
        AppData.userId,
        response.data["results"]["data"]["user"]["id"],
      );
      await SharedPreference.addStringToSF(
        AppData.role,
        response.data["results"]["data"]["user"]["role"],
      );

      AppData.roleValue = response.data["results"]["data"]["user"]["role"];
      AppData.userIdValue = response.data["results"]["data"]["user"]["id"];

      if (!["operator", "technician"].contains(
        response.data["results"]["data"]["user"]["role"]
            .toString()
            .toLowerCase()
            .trim(),
      )) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          RoutePath.homeScreen,
          (Route<dynamic> route) => false,
        );
      }
    } else {
      AppData.showSnackBar(context, response.data["message"]);
    }
    setState(() {
      loader = false;
    });
  }
}
