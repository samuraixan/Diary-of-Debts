import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:first_open_project/models/client_pages/create_client_response_model.dart';
import 'package:first_open_project/models/seller_pages_model/activate_seller_response_model.dart';
import 'package:first_open_project/models/seller_pages_model/create_seller_response_model.dart';
import 'package:first_open_project/models/shop_pages_model/create_shop_response_model.dart';
import 'package:first_open_project/models/login_pages_model/login_user_response_model.dart';
import 'package:first_open_project/models/login_pages_model/register_responce_model.dart';
import 'package:first_open_project/models/shop_pages_model/show_shop_response_model.dart';
import 'package:first_open_project/models/shop_pages_model/user_shops_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ApiClient {
  Dio? _dio;
  String token = '';

  getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var tokenBearer = preferences.getString('token');
    token = tokenBearer ?? '';
  }

  ApiClient() {
    _dio = Dio();
  }

  init() async {
    await getToken();
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    _dio?.options.headers = headers;
  }

  Future<dynamic> fetchData(String url) async {
    try {
      await init();
      final responce = await _dio!.post(
          'https://api.pdaftar.devdata.uz/api/v1/');
      return responce.data;
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }


  Future<dynamic> registerUser(String name, String email, String password,
      String passwordConfirmation) async {
    try {
      // var headers = {
      //   'Accept': 'application/json',
      //   'Content-Type': 'application/json'
      // };
      await init();
      final responce = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/register',
        data: {
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
        },
        // options: Options(
        //   headers: headers,
        // ),
      );
      return responce.data;
    } catch (e) {
      RegisterResponce registerResponce = RegisterResponce();
      registerResponce.success = false;
      return registerResponce.toJson();
      // if (e is DioException && e.response != null) {
      //   print('Server message: ${e.response!.data}');
      // }
      // throw Exception('Failed to register: $e');
    }
  }

  Future<dynamic> otpGenerate(String email) async {
    try {
      final responce = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/otp/generate',
        data: {
          'email': email,
        },
      );
      return responce.data;
    } catch (e) {
      throw Exception('Failed to OTP: $e');
    }
  }

  Future<dynamic> otpLogin(String userId, String otp) async {
    var headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "user_id": userId,
      "otp": otp
    });
    var dio = Dio();
    Response response = await dio.request(
      'https://api.pdaftar.devdata.uz/api/v1/otp/login',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    return response;
    // try {
    //   final responce = await _dio!.post(
    //     'https://api.pdaftar.devdata.uz/api/v1/otp/login',
    //     data: {
    //       'user_id': userId,
    //       'otp': otp,
    //     },
    //   );
    //   return responce.statusCode == 200;
    //   print(json.encode(responce.data));
    // } catch (e) {
    //   OTPLoginResponse r = OTPLoginResponse();
    //    resp= false;
    //   return r.toJson();
    //   // throw Exception('Failed to OTP: $e');
    // }
  }


  Future<dynamic> loginUser(String email, String password) async {
    try {
      await init();
      final responce = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      return responce.data;
    } catch (e) {
      LoginUserResponse response = LoginUserResponse();
      response.success = false;
      return response.toJson();
      // throw Exception('Failed to login: $e');
    }
  }

  Future<dynamic> createShop(String name, String address) async {
    try {
      await init();
      final responce = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/shops',
        data: {
          'name': name,
          'address': address,
        },
      );
      return responce.data;
    } catch (e) {
      CreateSHopResponse response = CreateSHopResponse();
      response.success = false;
      // return response.toJson();
      throw Exception('Failed to login: $e');
    }
  }

  Future<dynamic> getShops() async {
    try {
      await init();
      final response = await _dio!.get(
          'https://api.pdaftar.devdata.uz/api/v1/user_shops');
      return response.data;
    } catch (e) {
      UserShopsResponse response = UserShopsResponse();
      response.success == false;
      // Обработка ошибок
      throw Exception('Failed to get shops: $e');
    }
  }

  Future<dynamic> updateShop(String updateName, String updateAddress, int shopId) async {
    await init();
    var data = json.encode({
      "name": updateName,
      "address": updateAddress
    });
    try {
      var response = await _dio!.request(
        'https://api.pdaftar.devdata.uz/api/v1/shops/$shopId',
        options: Options(
          method: 'PUT',
          headers: _dio!.options.headers,
        ),
        data: data,
      );
      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print(e.toString());
    }
  }


Future<dynamic> deleteShop(String deleteId) async {
    await init();
    var data = '''''';
    try {
      var response = await _dio!.request(
        'https://api.pdaftar.devdata.uz/api/v1/shops/$deleteId',
        options: Options(
          method: 'DELETE',
          headers: _dio!.options.headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        return response.data;
      }
      else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> showShops(String shopShowId) async {
    try {
      await init();
      final response = await _dio!.get(
          'https://api.pdaftar.devdata.uz/api/v1/shops/$shopShowId');
      return response.data;
    } catch (e) {
      ShowShopResponse shopResponse = ShowShopResponse();
      shopResponse.success == false;
      // Обработка ошибок
      throw Exception('Failed to show shops: $e');
    }
  }

  Future<dynamic> createSeller(String shopId, String label) async {
    try {
      await init();
      final response = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/sellers',
        data: {
          'shop_id': shopId,
          'label': label,
        },
      );
      return response.data;
    } catch (e) {
      CreateSellerResponse createSellerResponse = CreateSellerResponse();
      createSellerResponse.success = false;
      // return createSellerResponse.toJson();
      throw Exception('Failed to create seller: $e');
    }
  }

  Future<dynamic> activateSeller(String activateCode) async {
    try {
      await init();
      final response = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/activate_sellers',
        data: {
          'activation_code': activateCode,
        },
      );
      return response.data;
    } catch (e) {
      ActivateSellerResponse activateSellerResponse = ActivateSellerResponse();
      activateSellerResponse.success == false;
      // return createSellerResponse.toJson();
      throw Exception('Failed to activate seller: $e');
    }
  }

  Future<dynamic> createClient(String shopId, String clientName, String clientPhoneNumber, String clientAddress) async {
    try {
      await init();
      final response = await _dio!.post(
        'https://api.pdaftar.devdata.uz/api/v1/clients',
        data: {
          "shop_id": shopId,
          "name": clientName,
          "phone_number": clientPhoneNumber,
          "address": clientAddress
        },
      );
      return response.data;
    } catch (e) {
      CreateClientResponse createClientResponse = CreateClientResponse();
      createClientResponse.success == false;
      // return createSellerResponse.toJson();
      throw Exception('Failed to activate seller: $e');
    }
  }

}

