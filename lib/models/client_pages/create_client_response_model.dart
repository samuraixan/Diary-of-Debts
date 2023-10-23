class CreateClientResponse {
  Data? data;
  String? message;
  bool? success;

  CreateClientResponse({this.data, this.message, this.success});

  CreateClientResponse.fromJson(Map<String, dynamic> json) {
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
  int? id;
  Shop? shop;
  String? name;
  String? phone;
  String? address;

  Data({this.id, this.shop, this.name, this.phone, this.address});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    shop = json['shop'] != null ? new Shop.fromJson(json['shop']) : null;
    name = json['name'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.shop != null) {
      data['shop'] = this.shop!.toJson();
    }
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}

class Shop {
  int? id;
  String? name;
  String? address;

  Shop({this.id, this.name, this.address});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    return data;
  }
}
