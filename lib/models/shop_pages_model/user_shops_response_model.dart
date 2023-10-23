class UserShopsResponse {
  List<UserShop>? data;
  String? message;
  bool? success;

  UserShopsResponse({this.data, this.message, this.success});

  UserShopsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserShop>[];
      json['data'].forEach((v) {
        data!.add(new UserShop.fromJson(v));
      });
    }
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['success'] = this.success;
    return data;
  }
}

class UserShop {
  int? id;
  String? name;
  String? address;

  UserShop({this.id, this.name, this.address});

  UserShop.fromJson(Map<String, dynamic> json) {
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
