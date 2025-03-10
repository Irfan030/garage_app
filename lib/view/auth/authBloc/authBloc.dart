import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/constant.dart';
import 'package:garage_app/repository/formSubmissionStatus.dart';
import 'package:garage_app/sharedpreference.dart';
import 'package:garage_app/view/auth/authBloc/authEvent.dart';
import 'package:garage_app/view/auth/authBloc/authState.dart';
import 'package:garage_app/view/auth/authRepository.dart';
import 'package:garage_app/view/auth/userModel.dart';

class Authbloc extends Bloc<AuthEvent, AuthState> {
  final Authrepository? authrepository = Authrepository();

  Authbloc() : super(AuthState()) {
    on<AuthSignUp>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        var params = {
          "email": event.email,
          "firstName": event.firstName,
          "lastName": event.lastName,
          "mobileNo": event.phoneNo,
        };
        var response = await authrepository?.signUp(params);
        if (response["code"] == 201 && !response["error"]) {
          emit(state.copyWith(formStatus: SubmissionSuccess()));
        } else {
          emit(
            state.copyWith(formStatus: SubmissionFailed(response["message"])),
          );
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    });
    on<AuthVerifyOtp>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        var params = {"email": event.email, "otp": event.otp};
        var response = await authrepository?.verifyOtp(params);
        if (response["code"] == 200 && !response["error"]) {
          emit(
            state.copyWith(
              formStatus: SubmissionSuccess(),
              email: event.email,
              token: response["results"]["data"]["token"],
            ),
          );
        } else {
          emit(
            state.copyWith(formStatus: SubmissionFailed(response["message"])),
          );
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    });
    on<AuthSetPassword>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      try {
        var params = {
          "email": state.email,
          "password": event.password,
          "confirmPassword": event.confirmPassword,
          "token": state.token,
        };
        var response = await authrepository?.setPassword(params);
        if (response["code"] == 200 && !response["error"]) {
          emit(
            state.copyWith(
              formStatus: SubmissionSuccess(),
              email: "",
              token: "",
            ),
          );
        } else {
          emit(
            state.copyWith(formStatus: SubmissionFailed(response["message"])),
          );
        }
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    });
    on<AuthLogin>((event, emit) async {
      emit(state.copyWith(formStatus: FormSubmitting()));
      // try {
      var params = {
        "email": event.email,
        "password": event.password,
        "persistentLogin": true,
      };
      var response = await authrepository?.login(params);
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
        emit(
          state.copyWith(
            formStatus: SubmissionSuccess(),
            email: "",
            token: "",
            userModel: UserModel.fromJson(response.data),
          ),
        );
      } else {
        emit(
          state.copyWith(
            formStatus: SubmissionFailed(response.data["message"]),
          ),
        );
      }
      // } catch (e) {

      //   emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      // }
    });
  }
}
