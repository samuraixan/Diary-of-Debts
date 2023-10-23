class CreateSellerResponse {
  Data? data;
  String? message;
  bool? success;

  CreateSellerResponse({this.data, this.message, this.success});

  CreateSellerResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class Data {
  int? activationCode;

  Data({this.activationCode});

  Data.fromJson(Map<String, dynamic> json) {
    activationCode = json['activation_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['activation_code'] = this.activationCode;
    return data;
  }
}
