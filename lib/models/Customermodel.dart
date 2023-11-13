class Customermodel {
  int? cusId;
  String? cusFname;
  String? cusLname;
  String? gender;
  String? mpType;
  String? cusCode;
  int? indays;
  int? mpduration;
  String? history;
  int? age;
  num? cusweight;
  num? cusheight;

  Customermodel(
      {this.cusId,
      this.cusFname,
      this.cusLname,
      this.gender,
      this.mpType,
      this.cusCode,
      this.indays,
      this.mpduration,
      this.history,
      this.age,
      this.cusheight,
      this.cusweight});

  Customermodel.fromJson(Map<String, dynamic> json) {
    cusId = json['cus_id'];
    cusFname = json['cus_fname'];
    cusLname = json['cus_lname'];
    gender = json['gender'];
    mpType = json['mp_Type'];
    cusCode = json['cus_code'];
    indays = json['indays'];
    mpduration = json['mp_duration'];
    history = json['history'];
    age = json['age'];
    cusheight = json['cus_height'];
    cusweight = json['cus_weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cus_id'] = this.cusId;
    data['cus_fname'] = this.cusFname;
    data['cus_lname'] = this.cusLname;
    data['gender'] = this.gender;
    data['mp_Type'] = this.mpType;
    data['cus_code'] = this.cusCode;
    data['indays'] = this.indays;
    data['mp_duration'] = this.mpduration;
    data['history'] = this.history;
    data['age'] = this.age;
    data['cus_weight'] = this.cusweight;
    data['cus_height'] = this.cusheight;
    return data;
  }
}
