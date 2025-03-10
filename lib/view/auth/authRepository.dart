import 'package:dio/dio.dart';
import 'package:garage_app/repository/api.dart';

class Authrepository {
  Api api = Api();

  Future signUp(param) async {
    try {
      var response = await api.sendRequest.post(
        "auth/create-user",
        data: param,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data;
      }
      return e;
    }
  }

  Future verifyOtp(param) async {
    try {
      var response = await api.sendRequest.post(
        "auth/verify-otp/email",
        data: param,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data;
      }
      return e;
    }
  }

  Future setPassword(param) async {
    try {
      var response = await api.sendRequest.post(
        "auth/create-password",
        data: param,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data;
      }
      return e;
    }
  }

  Future login(param) async {
    try {
      var response = await api.sendRequest.post("auth/login", data: param);
      api.sendRequest.options.headers['Authorization'] =
          response.headers['Authorization']?[0];
      return response;
    } catch (e) {
      if (e is DioException) {
        return e.response!;
      }
      return e;
    }
  }

  Future forgotPassword(param) async {
    try {
      var response = await api.sendRequest.post(
        "auth/forgotPassword",
        data: param,
      );
      return response.data;
    } catch (e) {
      if (e is DioException) {
        return e.response!.data;
      }
      return e;
    }
  }
}
