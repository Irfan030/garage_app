import 'package:garage_app/repository/formSubmissionStatus.dart';
import 'package:garage_app/view/auth/userModel.dart';

class AuthState {
  final FormSubmissionStatus formSubmissionStatus;
  final String email;
  final String token;
  final UserModel? userModel;

  AuthState({
    this.formSubmissionStatus = const InitialFormStatus(),
    this.email = "",
    this.token = "",
    this.userModel,
  });
  AuthState copyWith({
    FormSubmissionStatus? formStatus,
    String? email,
    String? token,
    UserModel? userModel,
  }) {
    return AuthState(
      formSubmissionStatus: formStatus ?? formSubmissionStatus,
      email: email ?? this.email,
      token: token ?? this.token,
      userModel: userModel ?? this.userModel,
    );
  }
}
