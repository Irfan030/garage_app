abstract class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String? email;
  final String? password;

  AuthLogin({this.email, this.password});
}

class AuthSignUp extends AuthEvent {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phoneNo;

  AuthSignUp({this.firstName, this.lastName, this.email, this.phoneNo});
}

class AuthVerifyOtp extends AuthEvent {
  final String? email;
  final String? otp;

  AuthVerifyOtp(this.email, this.otp);
}

class AuthSetPassword extends AuthEvent {
  final String? email;
  final String? password;
  final String? confirmPassword;
  final String? token;

  AuthSetPassword({
    this.email,
    this.password,
    this.confirmPassword,
    this.token,
  });
}

class VerifySession extends AuthEvent {}

class AuthLoginSubmitted extends AuthEvent {
  final String? username;
  final String? password;
  AuthLoginSubmitted({this.username, this.password});
}
