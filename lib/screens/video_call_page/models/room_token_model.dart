class RoomToken {
  int? result;
  String? token;

  RoomToken({this.result, this.token});

  RoomToken.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['result'] = this.result;
    data['token'] = this.token;
    return data;
  }
}


