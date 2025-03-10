import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/repository/formSubmissionStatus.dart';
import 'package:garage_app/route/routePath.dart';
import 'package:garage_app/view/auth/authBloc/authBloc.dart';
import 'package:garage_app/view/auth/authBloc/authEvent.dart';
import 'package:garage_app/view/auth/authBloc/authState.dart';
import 'package:garage_app/widget/authHeader.dart';
import 'package:garage_app/widget/defaultButton.dart';
import 'package:garage_app/widget/passwordInput.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  String password = "", confirmPassword = "";
  final _formKey = GlobalKey<FormState>();

  Future<bool> _onWillPop(BuildContext context) async {
    final result =
        await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Are you sure?'),
                content: const Text('Do you want to go back?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Yes'),
                  ),
                ],
              ),
        ) ??
        false;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<Authbloc, AuthState>(
      listener: (BuildContext context, AuthState state) {
        final formStatus = state.formSubmissionStatus;
        if (formStatus is SubmissionFailed) {
          AppData.showSnackBar(context, formStatus.exception.toString());
        } else if (formStatus is SubmissionSuccess) {
          Navigator.of(context).pushNamed(RoutePath.login);
        }
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) async {
          if (!didPop) {
            final shouldPop = await _onWillPop(context);
            if (shouldPop) {
              Navigator.of(context).pushNamed(RoutePath.login);
            }
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                AuthHeader(
                  title: "Create \nNew Password",
                  showBackButton: true,
                  backbutton: () {
                    _onWillPop(context);
                  },
                  subtitle: "Enter New Password",
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      PasswordInput(
                        hint: "Enter Password",
                        label: "Enter New Password",
                        onChange: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        validator: AppData.isPasswordValid(password),
                        errorMsg:
                            AppData.isPasswordValid(password)
                                ? "Password must have at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character"
                                : "",
                      ),
                      const SizedBox(height: 20),
                      PasswordInput(
                        hint: "Enter Password",
                        label: "Confirm New Password",
                        validator:
                            confirmPassword.isEmpty
                                ? true
                                : confirmPassword != password
                                ? true
                                : false,
                        errorMsg:
                            confirmPassword.isEmpty
                                ? "Password is required"
                                : confirmPassword != password
                                ? "Passwords do not match"
                                : "",
                        onChange: (value) {
                          setState(() {
                            confirmPassword = value;
                          });
                        },
                      ),
                      const SizedBox(height: 40),
                      submitBtn(),
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
          text: "Confirm",
          loading: state.formSubmissionStatus is FormSubmitting,
          press: () {
            if (_formKey.currentState!.validate()) {
              context.read<Authbloc>().add(
                AuthSetPassword(
                  password: password,
                  confirmPassword: confirmPassword,
                ),
              );
            }
          },
        );
      },
    );
  }
}
