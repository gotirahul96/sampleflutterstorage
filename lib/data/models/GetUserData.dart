class GetUserData {
  User user;
  Error error;

  GetUserData({this.user, this.error});

  GetUserData.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    error = json['error'] != null ? new Error.fromJson(json['error']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.error != null) {
      data['error'] = this.error.toJson();
    }
    return data;
  }
}

class User {
  String username;
  int credits;
  List<String> ships;
  List<String> loans;

  User({this.username, this.credits, this.ships, this.loans});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    credits = json['credits'];
    ships = json['ships'].cast<String>();
    loans = json['loans'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['credits'] = this.credits;
    data['ships'] = this.ships;
    data['loans'] = this.loans;
    return data;
  }
}

class Error {
  String message;
  int code;

  Error({this.message, this.code});

  Error.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['code'] = this.code;
    return data;
  }
}