class Trainer {
  int? trId;
  String? trFname;
  String? trLname;
  String? trUname;

  Trainer({this.trId, this.trFname, this.trLname, this.trUname});

  Trainer.fromJson(Map<String, dynamic> json) {
    trId = json['tr_id'];
    trFname = json['tr_fname'];
    trLname = json['tr_lname'];
    trUname = json['tr_uname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tr_id'] = this.trId;
    data['tr_fname'] = this.trFname;
    data['tr_lname'] = this.trLname;
    data['tr_uname'] = this.trUname;
    return data;
  }
}
