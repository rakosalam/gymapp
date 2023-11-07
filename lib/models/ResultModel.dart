class ResultModel {
  int? id;
  int? result;
  String? message;

  ResultModel({this.id, this.result, this.message});

  ResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['result'] = this.result;
    data['message'] = this.message;
    return data;
  }
}
