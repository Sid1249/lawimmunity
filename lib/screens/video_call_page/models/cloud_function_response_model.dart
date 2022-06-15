class RoomToken {
  int? statusCode;
  dynamic? result;

  RoomToken({this.statusCode, this.result});

  RoomToken.fromJson(Map<dynamic, dynamic> json) {
    statusCode = json['statusCode'];
    result = json['result'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['statusCode'] = this.result;
    data['result'] = this.result;
    return data;
  }
}